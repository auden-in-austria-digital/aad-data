import urllib.request  # import urllib.request module
import csv  # import csv module
import re  # import regular expression module

# read input CSV file
with urllib.request.urlopen('https://raw.githubusercontent.com/auden-in-austria-digital/aad-data/main/metadata/csv/input_img_id.csv') as csv_file:
    lines = csv_file.read().decode('utf-8').splitlines()  # read, decode as UTF-8 (convert bytes object into string), split string into lines; assign list of strings (1 string per row) to lines var

# parse rows
csv_reader = csv.reader(lines)  # pass lines var to CSV reader object (to iterate over, and parse into list of fields, rows)
header = next(csv_reader)  # assign 1st row to header variable as list of fields, advance to next
data = list(csv_reader)  # return remaining rows to data variable as list of lists, one list of fields per row

# find indices of selected columns
img_index = header.index('img')
lrx_index = header.index('lrx')
lry_index = header.index('lry')
width_index = header.index('width')
height_index = header.index('height')
type_index = header.index('type')
ed_index = header.index('ed')
doc_index = header.index('doc')
repo_index = header.index('repository')
coll_index = header.index('collection')

i = 0  # set counter

# check CSV well-formedness and validate CSV values against rules
for row in data:

    row_num = i + 2  # define CSV row number

    if '' in row:
        raise SyntaxError(f'Empty field detected in line {row_num}.')

    # specify img value data type
    if not row[img_index].isdigit():
        raise TypeError(f'Error in line {row_num}: img ID must contain only digits.')

    # specify img value digit number
    if not len(row[img_index]) == 5:
        raise ValueError(f'Error in line {row_num}: img ID must consist of five digits.')

    # specify img value incrementation
    img_id_no = int(row[img_index])
    if not img_id_no == i + 1:
        raise ValueError(f'Error in line {row_num}: img ID must increment by 1.')

    # specify lrx value data type
    if not row[lrx_index].isdigit():
        raise TypeError(f'Error in line {row_num}: lrx value must contain only digits.')

    # specify lry value data type
    if not row[lry_index].isdigit():
        raise TypeError(f'Error in line {row_num}: lry value must contain only digits.')

    # specify width value data type
    if not row[width_index].isdigit():
        raise TypeError(f'Error in line {row_num}: width value must contain only digits.')

    # specify height value data type
    if not row[height_index].isdigit():
        raise TypeError(f'Error in line {row_num}: height value must contain only digits.')

    # specify type value options
    if row[type_index] not in ['envelope', 'sheet', 'card', 'photograph']:
        raise ValueError(f'Error in line {row_num}: type value must equal "envelope", "sheet", "card", or "photograph".')

    # specify ed value pattern
    if not re.match(r'^\d+[rv]$', row[ed_index]):
        raise ValueError(f'Error in line {row_num}: ed value must consist of a number plus the character "r" or "v".')

    # specify doc value data type
    if not row[doc_index].isdigit():
        raise TypeError(f'Error in line {row_num}: doc ID must contain only digits.')

    # specify doc value digit number
    if not len(row[doc_index]) == 4:
        raise ValueError(f'Error in line {row_num}: doc ID must consist of four digits.')

    # specify repository value restrictions
    if not all(char.isalpha() or char.isspace() for char in row[repo_index]):
        raise TypeError(f'Error in line {row_num}: repository value must contain only alphabetic characters and spaces.')

    # specify collection value restrictions
    if not all(char.isalpha() or char.isspace() or char == '.' for char in row[coll_index]):
        raise TypeError(f'Error in line {row_num}: collection value must contain only alphabetic characters, spaces, and periods.')

    i += 1  # increment counter
