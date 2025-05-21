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
    
    # create dictionary that relates authors to pandas series of month-documents counts
    monthly_counts = {
        author: df.resample('ME').size()[lambda x: x > 0]  # make author key; for value resample author-based dataframe by month-end, count entries, filter out zero values
        for author, df in author_dfs.items()  # iterate through authors_dfs dictionary as tuples
    }
    
    return monthly_counts


def create_monthly_scatter_plot(monthly_counts, output_path):
    '''creates scatter plot of monthly document counts'''
    # set plot style and create figure
    plt.style.use('seaborn-v0_8-whitegrid')  # set visual style to white background with light grid lines
    fig, ax = plt.subplots(figsize=(18, 10), dpi=300)  # create figue and axes objects (as current project in this plot); set dimensions in inches, set resolution
    
    # create dictionaries of author colors
    colors = {
        'Auden': '#191970',
        'Kallman': '#40E0D0',
        'Other': '#B59410'
    }
    
    # define offset
    offset = pd.DateOffset(days=7)
    
    # plot individual author data (from multiple pandas series) with divergent offsets
    ax.scatter(  # render the axes object as scatter plot
        monthly_counts['Auden'].index - offset,  # pass x-axis values (index labels of pandas series); define negative offset
        monthly_counts['Auden'],  # pass y-axis values (values of pandas series)
        s=100,  # set marker size
        color=colors['Auden'],  # set color
        label='W. H. Auden',  # set label
        marker='.',  # set marker style
        alpha=0.7  # set marker opacity
    )
    
    ax.scatter(
        monthly_counts['Kallman'].index,
        monthly_counts['Kallman'],
        s=100,
        color=colors['Kallman'],
        label='Chester Kallman',
        marker='.',
        alpha=0.7
    )
    
    ax.scatter(
        monthly_counts['Other'].index + offset,  # define positive offset
        monthly_counts['Other'],
        s=100,
        color=colors['Other'],
        label='others',
        marker='.',
        alpha=0.7
    )
    
    # configure axes
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y'))  # set x-axis labels to year format
    ax.xaxis.set_major_locator(mdates.YearLocator())  # set major x-axis tick marks to beginning of each year
    plt.xticks(rotation=90)  # align x-axis labels vertically
    ax.yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # set major y-axis tick marks to integer positions
    
    # configure title and labels
    ax.set_title('number of documents per month (UTC) by author', fontsize=16, pad=20)  # set title; define font size and padding
    ax.set_xlabel('month', fontsize=14, labelpad=10)
    ax.set_ylabel('number of documents', fontsize=14, labelpad=10)
    
    # configure legend and grid
    ax.legend(fontsize=12, frameon=True, facecolor='white', edgecolor='gray', loc='upper right')
    ax.grid(True, linestyle='--', alpha=0.7)  # set grid line style to dashed; set grid line opacity
    
    plt.tight_layout()  # adjust plot paramaters for better fit

    # save and close plot
    plt.savefig(
        output_path,
        dpi=300,
        bbox_inches='tight',  # trim excess whitespace around plot
        facecolor='white',  # set background to white
        edgecolor='none'  # remove border
    )
    plt.close()


def create_annual_summary(df_date, output_path):
    '''creates bar chart of annual document count by author'''
    # create dictionaries of author colors
    colors = {
        'Auden': '#191970',
        'Kallman': '#40E0D0',
        'Other': '#B59410'
    }

    # group by year
    df_date = df_date.copy()  # copy date-based dataframe
    df_date['year'] = df_date.index.year  # create column for years from datetime index
    author_counts = df_date.groupby(['year', 'author']).size().unstack(fill_value=0)  # create pandas series with year-author multi-index and document numbers as values; make last level of multi-index column headings of new dataframe (and years as row indices), fill any NaN with 0
    
    # add author columns (if there are no documents of these authors)
    for author in ['Auden, W. H.', 'Kallman, Chester']:
        if author not in author_counts.columns:
            author_counts[author] = 0
    
    # create column for other authors
    author_counts['Other'] = author_counts.drop(  # add resulting pandas series as column to dataframe
        columns=['Auden, W. H.', 'Kallman, Chester']  # drop Auden and Kallman columns
    ).sum(axis=1)  # add up values for each of remaining rows
    
    # reduce dataframe to relevant columns
    author_counts = author_counts[['Auden, W. H.', 'Kallman, Chester', 'Other']]
    
    # create bar chart
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(16, 8), dpi=300)
    
    author_counts.plot(  # create plot directly from dataframe
        kind='bar',  # set style to bar chart
        stacked=True,  # stack bars for each author
        color=[colors['Auden'], colors['Kallman'], colors['Other']],
        ax=ax,  # plot on axes object specified above
        width=0.7  # reduce bar width
    )
    
    # add title and labels
    ax.set_title('number of documents per year (UTC) by author', fontsize=16, pad=20)
    ax.set_xlabel('year', fontsize=14, labelpad=10)
    ax.set_ylabel('number of documents', fontsize=14, labelpad=10)
    
    # add legend and grid
    ax.legend(
        ['W. H. Auden', 'Chester Kallman', 'others'],
        fontsize=12, 
        frameon=True, 
        facecolor='white', 
        edgecolor='gray'
    )
    ax.grid(axis='y', linestyle='--', alpha=0.7)
    
    plt.tight_layout()

    # save plot
    plt.savefig(
        output_path,
        dpi=300,
        bbox_inches='tight',
        facecolor='white',
        edgecolor='none'
    )
    plt.close()


def create_markdown_report(df_summary, df_info, df_doc, output_path):
    '''generates markdown report with visualizations and analysis'''
    with open(output_path, 'w') as f:  # open file in write mode
        f.write(f'### cleaned document data\n')  # write text to file using f-string formatting and markdown syntax
        f.write(f'```\n{df_doc.to_string()}\n```\n\n')  # insert string representation of dataframe
        f.write(f'### distribution per month\n\n')
        f.write(f'![number of documents per month by author](docs_per_month_by_author.png)\n\n')  # insert image, indicate alt text
        f.write(f'### distribution per year\n\n')
        f.write(f'![annual document count by author](annual_docs_by_author.png)\n\n')
        f.write(f'## `input_img_id.csv` analysis report\n\n')
        f.write(f'### `df.isnull().sum()`\n```\n{df_summary}\n```\n\n')
        f.write(f'### `df.info()`\n```\n{df_info}\n```')


def main():
    '''orchestrates workflow'''
    # define paths
    input_path = './metadata/csv/input_img_id.csv'
    monthly_viz_path = './metadata/md/docs_per_month_by_author.png'
    annual_viz_path = './metadata/md/annual_docs_by_author.png'
    report_path = './metadata/md/metadata-analysis.md'
    
    df, df_summary, df_info = read_and_analyze_data(input_path)  # call read_and_analyze_data() function
    
    df_doc, df_date = clean_and_prepare_data(df)  # call clean_and_prepare_data() function
    
    monthly_counts = create_author_dataframes(df_date)  # call create_author_dataframes() function
    
    # call create_monthly_scatter_plot() and create_annual_summary() functions
    create_monthly_scatter_plot(monthly_counts, monthly_viz_path)
    create_annual_summary(df_date, annual_viz_path)
    
    create_markdown_report(df_summary, df_info, df_doc, report_path)  # call create_markdown_report() function


# execute if script is run directly (but not automatically upon import)
if __name__ == "__main__":
    main()
