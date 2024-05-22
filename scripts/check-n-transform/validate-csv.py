import csv  # import csv module
import re  # import regular expression module

# read input CSV file
with open('./metadata/csv/input_img_id.csv', 'r', newline='', encoding='utf-8') as file:  # open input file in read mode, disable universal newlines mode, specify text as UTF-8-encoded
    lines = file.readlines()  # read lines and assign list of lines to lines var

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
title_index = header.index('title')
author_index = header.index('author')
notBefore_index = header.index('notBefore-iso')
notAfter_index = header.index('notAfter-iso')
repo_index = header.index('repository')
coll_index = header.index('collection')
idno_index = header.index('idno')

doc_dict = {}  # initiate document dictionary

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

    # specify collection value restrictions
    if not all(char.isalpha() or char.isspace() or char == '.' or char == ',' for char in row[author_index]):
        raise TypeError(f'Error in line {row_num}: author value must contain only alphabetic characters, spaces, commas, and periods.')

    # specify notBefore-iso value pattern
    if not re.match(r'^19[5-7]\d-[0-1]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\+[0-2]\d:00$', row[notBefore_index]):
        raise ValueError(f'Error in line {row_num}: notBefore-iso value must conform to ISO datetime format.')

    # specify notAfter-iso value pattern
    if not re.match(r'^19[5-7]\d-[0-1]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\+[0-2]\d:00$', row[notAfter_index]):
        raise ValueError(f'Error in line {row_num}: notAfter-iso value must conform to ISO datetime format.')

    # specify title value restrictions
    if not (row[notBefore_index][:10] in row[title_index] and row[notAfter_index][:10] in row[title_index]):
        raise ValueError(f'Error in line {row_num}: title does not match notBefore-iso and notAfter-iso values.')
    
    # specify repository value restrictions
    if not all(char.isalpha() or char.isspace() for char in row[repo_index]):
        raise TypeError(f'Error in line {row_num}: repository value must contain only alphabetic characters and spaces.')

    # specify collection value restrictions
    if not all(char.isalpha() or char.isspace() or char == '.' for char in row[coll_index]):
        raise TypeError(f'Error in line {row_num}: collection value must contain only alphabetic characters, spaces, and periods.')

    # extract field values of current row
    doc_id = row[doc_index]
    title = row[title_index]
    author = row[author_index]
    notBefore = row[notBefore_index]
    notAfter = row[notAfter_index]
    repository = row[repo_index]
    collection = row[coll_index]
    idno = row[idno_index]

    # check consistency of value constellation in current row against constellations in document dictionary
    if doc_id in doc_dict:
        if (doc_dict[doc_id][title_index] != title or
                doc_dict[doc_id][author_index] != author or
                doc_dict[doc_id][notBefore_index] != notBefore or
                doc_dict[doc_id][notAfter_index] != notAfter or
                doc_dict[doc_id][repo_index] != repository or
                doc_dict[doc_id][coll_index] != collection or
                doc_dict[doc_id][idno_index] != idno):
            raise ValueError(f'Inconsistent values detected in line {row_num} for document {doc_id}.')
    else:
        doc_dict[doc_id] = row

    i += 1  # increment counter
