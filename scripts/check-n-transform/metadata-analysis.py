import pandas as pd  # import pandas library
import matplotlib.pyplot as plt  # import Matplotlib pyplot module
import matplotlib.dates as mdates  # import Matplotlib dates module
from io import StringIO  # import io StringIO module


def read_and_analyze_data(csv_path):
    '''reads CSV file and performs overview analysis'''
    df = pd.read_csv(csv_path, dtype={'doc': 'str'})  # initialize dataframe, treat `doc` values as string
    
    null_summary = df.isnull().sum()  # count null values in columns
    
    # get dataframe info
    buffer = StringIO()  # initialize in-memory text stream object
    df.info(buf=buffer)  # send dataframe info to buffer (instead of printing)
    df_info = buffer.getvalue()  # store buffer contents
    
    return df, null_summary, df_info  # return dataframe, null-value summary, dataframe info


def clean_and_prepare_data(df):
    '''cleans data and prepares for visualization'''
    # create document-based dataframe
    df_doc = df.drop_duplicates(subset='doc')[['doc', 'author', 'title', 'place']]  # remove duplicate rows with same `doc` values, keep only selected values
    df_doc.set_index('doc', inplace=True)  # set `doc` value as index, modify dataframe directly
    
    # create date-based dataframe
    df_date = df.drop_duplicates(subset='doc')[['doc', 'author', 'notBefore-iso']]
    df_date['notBefore-iso'] = pd.to_datetime(df_date['notBefore-iso'], errors='coerce', utc=True)  # convert strings to datetime objects, convert unparseable dates to NaT, standardize to UTC
    df_date = df_date.dropna(subset=['notBefore-iso'])  # remove rows with NaT
    df_date.set_index('notBefore-iso', inplace=True)
    
    return df_doc, df_date


def create_author_dataframes(df_date):
    '''creates separate dataframes by author and resamples by month'''
    # create dictionary of date-based dataframes by author
    author_dfs = {
        'Auden': df_date[df_date['author'] == 'Auden, W. H.'],
        'Kallman': df_date[df_date['author'] == 'Kallman, Chester'],
        'Other': df_date[(df_date['author'] != 'Auden, W. H.') & 
                         (df_date['author'] != 'Kallman, Chester')]
    }
    
    # create dictionary that relates authors to series of month-documents counts
    monthly_counts = {
        author: df.resample('ME').size()[lambda x: x > 0]  # make author the key; for value resample author-based dataframe by month-end, count entries, filter out zero values
        for author, df in author_dfs.items()  # access authors_dfs dictionary as tuples
    }
    
    return monthly_counts


def create_monthly_scatter_plot(monthly_counts, output_path):
    """Create an enhanced scatter plot of monthly document counts"""
    # Set plot style and create figure
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(18, 10), dpi=300)
    
    # Define colors to match original design
    colors = {
        'Auden': '#191970',    # Dark blue for Auden (as requested)
        'Kallman': '#40E0D0',  # Turquoise for Kallman (as requested)
        'Other': '#B59410'     # Gold for others (as requested)
    }
    
    # Define offsets to match original design
    offset = pd.DateOffset(days=7)
    
    # Plot each author's data with specific requirements
    ax.scatter(
        monthly_counts['Auden'].index - offset,  # Negative offset for Auden
        monthly_counts['Auden'],
        s=100,
        color=colors['Auden'],
        label='W. H. Auden',
        marker='.',  # Dot marker as requested
        alpha=0.7
    )
    
    ax.scatter(
        monthly_counts['Kallman'].index,  # No offset for Kallman
        monthly_counts['Kallman'],
        s=100,
        color=colors['Kallman'],
        label='Chester Kallman',
        marker='.',  # Dot marker as requested
        alpha=0.7
    )
    
    ax.scatter(
        monthly_counts['Other'].index + offset,  # Positive offset for others
        monthly_counts['Other'],
        s=100,
        color=colors['Other'],
        label='others',
        marker='.',  # Dot marker as requested
        alpha=0.7
    )
    
    # Configure axes
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m'))
    ax.xaxis.set_major_locator(mdates.YearLocator())
    plt.xticks(rotation=45)
    ax.yaxis.set_major_locator(plt.MaxNLocator(integer=True))
    
    # Add labels and styling
    ax.set_title('number of documents per month (UTC) by author', fontsize=16, pad=20)
    ax.set_xlabel('month', fontsize=14, labelpad=10)
    ax.set_ylabel('number of documents', fontsize=14, labelpad=10)
    
    # Add legend and grid
    ax.legend(fontsize=12, frameon=True, facecolor='white', edgecolor='gray', loc='upper right')
    ax.grid(True, linestyle='--', alpha=0.7)
    
    # Save figure
    plt.tight_layout()
    plt.savefig(
        output_path,
        dpi=300,
        bbox_inches='tight',
        facecolor='white',
        edgecolor='none'
    )
    plt.close()


def create_annual_summary(df_date, output_path):
    """Create annual summary bar chart by author"""
    # Define colors to match monthly visualization
    colors = {
        'Auden': '#191970',    # Dark blue for Auden
        'Kallman': '#40E0D0',  # Turquoise for Kallman
        'Other': '#B59410'     # Gold for others
    }
    # Group by year
    df_date = df_date.copy()  # Create a copy to avoid modifying the original
    df_date['year'] = df_date.index.year
    author_counts = df_date.groupby(['year', 'author']).size().unstack(fill_value=0)
    
    # Ensure all author columns exist
    for author in ['Auden, W. H.', 'Kallman, Chester']:
        if author not in author_counts.columns:
            author_counts[author] = 0
    
    # Create 'Other' column
    columns_of_interest = ['Auden, W. H.', 'Kallman, Chester']
    author_counts['Other'] = author_counts.drop(
        columns=columns_of_interest, 
        errors='ignore'
    ).sum(axis=1)
    
    # Select only relevant columns in order
    author_counts = author_counts[columns_of_interest + ['Other']]
    
    # Create bar chart
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(16, 8), dpi=300)
    
    author_counts.plot(
        kind='bar', 
        stacked=True,
        color=[colors['Auden'], colors['Kallman'], colors['Other']],
        ax=ax,
        width=0.7
    )
    
    # Add labels and styling
    ax.set_title('number of documents per year (UTC) by author', fontsize=16, pad=20)
    ax.set_xlabel('year', fontsize=14, labelpad=10)
    ax.set_ylabel('number of documents', fontsize=14, labelpad=10)
    
    # Add legend and grid
    ax.legend(
        ['W. H. Auden', 'Chester Kallman', 'others'],
        fontsize=12, 
        frameon=True, 
        facecolor='white', 
        edgecolor='gray'
    )
    ax.grid(axis='y', linestyle='--', alpha=0.7)
    
    # Save figure
    plt.tight_layout()
    plt.savefig(
        output_path,
        dpi=300,
        bbox_inches='tight',
        facecolor='white',
        edgecolor='none'
    )
    plt.close()


def create_markdown_report(df_summary, df_info, df_doc, output_path):
    """Generate markdown report with visualizations and analysis"""
    with open(output_path, 'w') as f:
        f.write(f'## `input_img_id.csv` analysis report\n\n')
        f.write(f'### `df.isnull().sum()`\n```\n{df_summary}\n```\n\n')
        f.write(f'### `df.info()`\n```\n{df_info}\n```\n\n')
        f.write(f'### cleaned document data\n')
        f.write(f'```\n{df_doc.to_string()}\n```\n\n')
        f.write(f'### distribution per month\n\n')
        f.write(f'![number of documents per month by author](docs_per_month_by_author.png)\n\n')
        f.write(f'### distribution per year\n\n')
        f.write(f'![annual document count by author](annual_docs_by_author.png)')


def main():
    """Main function to orchestrate the entire workflow"""
    # Define paths
    input_path = './metadata/csv/input_img_id.csv'
    monthly_viz_path = './metadata/md/docs_per_month_by_author.png'
    annual_viz_path = './metadata/md/annual_docs_by_author.png'
    report_path = './metadata/md/metadata-analysis.md'
    
    # Define colors for consistency across visualizations
    colors = {
        'Auden': '#1f77b4',  # Deep blue
        'Kallman': '#2ca02c',  # Strong green
        'Other': '#ff7f0e'   # Vibrant orange
    }
    
    # Read and analyze data
    df, df_summary, df_info = read_and_analyze_data(input_path)
    
    # Clean and prepare data
    df_doc, df_date = clean_and_prepare_data(df)
    
    # Create author dataframes and monthly counts
    monthly_counts = create_author_dataframes(df_date)
    
    # Create visualizations
    create_monthly_scatter_plot(monthly_counts, monthly_viz_path)
    create_annual_summary(df_date, annual_viz_path)
    
    # Create report
    create_markdown_report(df_summary, df_info, df_doc, report_path)


if __name__ == "__main__":
    main()