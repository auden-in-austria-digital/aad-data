import pandas as pd  # import pandas library
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
df_date['notBefore-iso'] = pd.to_datetime(df_date['notBefore-iso'], errors='coerce')  # convert notBefore-iso string values to datetime objects, replace invalid string values with NaT values

df_date.set_index('notBefore-iso', inplace=True)  # set datetime objects as index

monthly_docs = df_date.resample('ME').size()  # resample into groups by month, count document number per group in series

plt.figure(figsize=(10, 5))    # initialize figure, set dimensions in inches
monthly_docs[monthly_docs > 0].plot(kind='line', marker='.', linestyle='None', color='#D4AF37')  # plot series in line plot if count < 0, set point markers, no lines, cyan color
plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # retrieve axes, set y-axis ticks to integers

# add labels
plt.title('number of documents per month')
plt.xlabel('time')
plt.ylabel('number')

plt.grid(True)  # display grid lines
plt.tight_layout()  # automatically adjust spacing between figure elements

plt.savefig('./metadata/md/docs_per_month.png')  # save figure

# doc-time-author plot

# create author-based dataframes
df_auden = df_date[df_date['author'] == 'Auden, W. H.']
df_other = df_date[df_date['author'] != 'Auden, W. H.']

# resample into groups by month, count document number per group in series
monthly_auden = df_auden.resample('ME').size()
monthly_other = df_other.resample('ME').size()

# filter out zero values
monthly_auden = monthly_auden[monthly_auden > 0]
monthly_others = monthly_other[monthly_other > 0]

plt.figure(figsize=(10, 5))  # initialize figure, set dimensions in inches

offset = pd.DateOffset(days=7)  # introduce x-axis offset

plt.scatter(monthly_auden.index - offset, monthly_auden, color='#000080', label='W. H. Auden', marker='.')  # plot Auden documents with offset
plt.scatter(monthly_others.index + offset, monthly_others, color='#FFDB58', label='other', marker='.')  # plot other documents with reverse offset

plt.gca().yaxis.set_major_locator(plt.MaxNLocator(integer=True))  # retrieve axes, set y-axis ticks to integers

# add labels
plt.title('number of documents per month by author')
plt.xlabel('time')
plt.ylabel('number')

plt.grid(True)  # display grid lines
plt.legend()  # add legend of labels
plt.tight_layout()  # automatically adjust spacing between figure elements

plt.savefig('./metadata/md/docs_per_month_by_author.png')  # save figure

# create markdown report

with open("metadata-analysis.md", "w") as f:
    f.write(f'## `input_img_id.csv` analysis report\n')
    f.write(f'### `df.isnull().sum()`\n```\n{df_summary}\n```\n')
    f.write(f'### `df.info()`\n```\n{df_info}\n```\n')
    f.write(f'### cleaned document data\n')
    f.write(f'```\n{df_doc.to_string()}\n```\n')
    f.write(f'### scatter plot\n\n')
    f.write(f'![number of documents per month](docs_per_month.png)\n')
    f.write(f'![number of documents per month by author](docs_per_month_by_author.png)')
