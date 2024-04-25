import csv  # import csv model
from lxml import etree  # import etree functionality from lxml library

tei_namespace = 'http://www.tei-c.org/ns/1.0'  # define TEI namespace

docs_list = []  # create list of document IDs

with open('./metadata/csv/output_doc_id.csv', 'r', newline='', encoding='utf-8') as csv_file:  # open input file in read mode, disable universal newlines mode, specify text as UTF-8-encoded
    table = csv.DictReader(csv_file, delimiter=',', quotechar='"')  # read CSV contents and parse rows into dictionaries

    for row in table:

        # target data common to all rows related to same document ID
        if row['doc'] not in docs_list:

            xml_id = 'aad-transcript__' + row['doc']  # define XML ID

            root = etree.Element('TEI', nsmap={None: tei_namespace})  # add root element
            root.set('{http://www.w3.org/XML/1998/namespace}id', xml_id)  # define root xml:id attribute

            # add teiHeader node
            tei_header = etree.SubElement(root, 'teiHeader')
            tei_filedesk = etree.SubElement(tei_header, 'fileDesk')
            tei_titlestmt = etree.SubElement(tei_filedesk, 'titleStmt')
            tei_title_s = etree.SubElement(tei_titlestmt, 'title', level='s')
            tei_title_s.text = 'Auden in Austria Digital'
            tei_title_a = etree.SubElement(tei_titlestmt, 'title', level='a')
            tei_title_a.text = row['title']
            tei_author = etree.SubElement(tei_titlestmt, 'author')
            tei_author.text = row['author']

            # add facsimile element
            tei_facsimile = etree.SubElement(root, 'facsimile')

            # add text node
            tei_text = etree.SubElement(root, 'text')
            tei_body = etree.SubElement(tei_text, 'body')

            file_name = './data/xml/tmp/' + xml_id + '.xml'  # define output file name

            docs_list.append(row['doc'])  # append current document ID to list of document IDs

        # target row-specific data
        tei_pb = etree.SubElement(tei_body, 'pb', facs='https://iiif.acdh.oeaw.ac.at/aad/aad_' + row['img'], ed=row['ed'], type=row['type'])  # add page-beginning element

        with open(file_name, 'w') as xml_file:  # open/create output XML file in write mode
            xml_file.write(etree.tostring(root, encoding='utf-8', xml_declaration=True, pretty_print=True).decode('utf-8'))  # convert XML ElementTree structure to UTF-8-encoded byte string; add XML declaration, indentation, and line breaks; decode UTF-8 byte string into Unicode string
