'''import pandas as pd  # import pandas library
import matplotlib.pyplot as plt  # import pyplot submodule of matplotlib library
from io import StringIO  # import StringIO functionality from io module

# inspect input_img_id.csv

df = pd.read_csv('./metadata/csv/input_img_id.csv', dtype={'doc': 'str'})  # read csv into dataframe, retain string data type for doc values

df_summary = df.isnull().sum()  # return True for None and NaN; sum up null values

buffer = StringIO()  # initiate instance of StringIO class as temporary in-memory file-like buffer
df.info(buf=buffer)  # send info() output to StringIO buffer object
df_info = buffer.getvalue()  # pass buffer string to var

# clean data

df_doc = df.drop_duplicates(subset='doc')[['doc', 'author', 'title', 'place']]  # drop subsequent rows with duplicate doc values
df_doc.set_index('doc', inplace=True)  # set doc values as index

# visualize data
# doc-time plot

df_date = df.drop_duplicates(subset='doc')[['doc', 'author', 'notBefore-iso']]
df_date['notBefore-iso'] = pd.to_datetime(df_date['notBefore-iso'], errors='coerce', utc=True)  # convert notBefore-iso string values to datetime objects, replace invalid string values with NaT values, standardize datetimes to UTC
df_date = df_date.dropna(subset=['notBefore-iso'])  # drop rows where UTC conversion failed

df_date.set_index('notBefore-iso', inplace=True)  # set datetime objects as index

monthly_docs = df_date.resample('ME').size()  # resample into groups by month, count document number per group in series

plt.figure(figsize=(10, 5))    # initialize figure, set dimensions in inches
monthly_docs[monthly_docs > 0].plot(kind='line', marker='.', linestyle='None', color='#D4AF37')  # plot series in line plot if count < 0, set point markers, no lines, cyan color
plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # retrieve axes, set y-axis ticks to integers

# add labels
plt.title('number of documents per month (UTC)')
plt.xlabel('time')
plt.ylabel('number')

plt.grid(True)  # display grid lines
plt.tight_layout()  # automatically adjust spacing between figure elements

plt.savefig('./metadata/md/docs_per_month.png')  # save figure

# doc-time-author plot

# create author-based dataframes
df_auden = df_date[df_date['author'] == 'Auden, W. H.']
df_other = df_date[df_date['author'] != 'Auden, W. H.']

# resample into groups by month, count document number per group in series, filter out zero values
monthly_auden = df_auden.resample('ME').size()[lambda x: x > 0]
monthly_other = df_other.resample('ME').size()[lambda x: x > 0]

plt.figure(figsize=(10, 5))  # initialize figure, set dimensions in inches

offset = pd.DateOffset(days=7)  # introduce x-axis offset

plt.scatter(monthly_auden.index - offset, monthly_auden, color='#000080', label='W. H. Auden', marker='.')  # plot Auden documents with offset
plt.scatter(monthly_other.index + offset, monthly_other, color='#FFDB58', label='other', marker='.')  # plot other documents with reverse offset

plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # retrieve axes, set y-axis ticks to integers

# add labels
plt.title('number of documents per month (UTC) by author')
plt.xlabel('time')
plt.ylabel('number')

plt.grid(True)  # display grid lines
plt.legend()  # add legend of labels
plt.tight_layout()  # automatically adjust spacing between figure elements

plt.savefig('./metadata/md/docs_per_month_by_author.png')  # save figure

# create markdown report

with open('./metadata/md/metadata-analysis.md', 'w') as f:
    f.write(f'## `input_img_id.csv` analysis report\n')
    f.write(f'### `df.isnull().sum()`\n```\n{df_summary}\n```\n')
    f.write(f'### `df.info()`\n```\n{df_info}\n```\n')
    f.write(f'### cleaned document data\n')
    f.write(f'```\n{df_doc.to_string()}\n```\n')
    f.write(f'### scatter plot\n\n')
    f.write(f'![number of documents per month](docs_per_month.png)\n')
    f.write(f'![number of documents per month by author](docs_per_month_by_author.png)')'''

import pandas as pd  # import pandas library
import matplotlib.pyplot as plt  # import pyplot submodule of matplotlib library
from io import StringIO  # import StringIO functionality from io module

# --- Inspect input_img_id.csv ---

df = pd.read_csv('./metadata/csv/input_img_id.csv', dtype={'doc': 'str'})  # Read CSV into dataframe, retain string data type for doc values

df_summary = df.isnull().sum()  # Count missing values per column

buffer = StringIO()  # Create an in-memory text buffer
df.info(buf=buffer)  # Write DataFrame info to buffer
df_info = buffer.getvalue()  # Retrieve buffer content as a string

# --- Clean Data ---

df_doc = df.drop_duplicates(subset='doc')[['doc', 'author', 'title', 'place']]  # Drop duplicate document entries, keep key columns
df_doc.set_index('doc', inplace=True)  # Set document ID as index

# --- Prepare Date-based DataFrame ---

df_date = df.drop_duplicates(subset='doc')[['doc', 'author', 'notBefore-iso']]
df_date['notBefore-iso'] = pd.to_datetime(df_date['notBefore-iso'], errors='coerce', utc=True)  # Convert to datetime (UTC), handle invalid values
df_date = df_date.dropna(subset=['notBefore-iso'])  # Remove rows with NaT values
df_date.set_index('notBefore-iso', inplace=True)  # Set datetime as index

# --- Compute Monthly Document Counts ---

# Ensure total documents per month are counted before splitting by author (for Plot 1)
monthly_docs = df_date.resample('ME').size().groupby(level=0).sum()
monthly_docs = monthly_docs[monthly_docs > 0]


# Now, split into author-based dataframes (for Plot 2)
df_auden = df_date[df_date['author'] == 'Auden, W. H.']
df_other = df_date[df_date['author'] != 'Auden, W. H.']

# Resample by month, count documents per group, filter out zero values
monthly_auden = df_auden.resample('ME').size()[lambda x: x > 0]
monthly_other = df_other.resample('ME').size()[lambda x: x > 0]

# --- PLOT 1: Documents Per Month (Single Dot Per Month) ---

plt.figure(figsize=(10, 5))  # Set figure size
plt.scatter(monthly_docs.index, monthly_docs, color='#D4AF37', marker='.')  # Single dot per month (gold color)
plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # Force y-axis labels as integers

# Add labels and formatting
plt.title('Number of Documents per Month (UTC)')
plt.xlabel('Time')
plt.ylabel('Number')
plt.grid(True)  # Display grid lines
plt.tight_layout()  # Adjust layout
plt.savefig('./metadata/md/docs_per_month.png')  # Save figure

# --- PLOT 2: Documents Per Month by Author (Separate Dots) ---

plt.figure(figsize=(10, 5))  # Set figure size
offset = pd.DateOffset(days=7)  # Offset to separate overlapping dots

# Plot separate dots for Auden and other authors
plt.scatter(monthly_auden.index - offset, monthly_auden, color='#000080', label='W. H. Auden', marker='.')  # Navy blue
plt.scatter(monthly_other.index + offset, monthly_other, color='#FFDB58', label='Other', marker='.')  # Soft gold

plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # Force y-axis labels as integers

# Add labels and formatting
plt.title('Number of Documents per Month (UTC) by Author')
plt.xlabel('Time')
plt.ylabel('Number')
plt.grid(True)  # Display grid lines
plt.legend()  # Add legend
plt.tight_layout()  # Adjust layout
plt.savefig('./metadata/md/docs_per_month_by_author.png')  # Save figure

# --- Create Markdown Report ---

with open('./metadata/md/metadata-analysis.md', 'w') as f:
    f.write(f'## `input_img_id.csv` Analysis Report\n')
    f.write(f'### Missing Values Summary (`df.isnull().sum()`)\n```\n{df_summary}\n```\n')
    f.write(f'### DataFrame Info (`df.info()`)\n```\n{df_info}\n```\n')
    f.write(f'### Cleaned Document Data\n')
    f.write(f'```\n{df_doc.to_string()}\n```\n')
    f.write(f'### Scatter Plots\n\n')
    f.write(f'![Number of Documents per Month](docs_per_month.png)\n')
    f.write(f'![Number of Documents per Month by Author](docs_per_month_by_author.png)\n')
