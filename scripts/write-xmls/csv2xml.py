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
            tei_filedesc = etree.SubElement(tei_header, 'fileDesc')
            tei_titlestmt = etree.SubElement(tei_filedesc, 'titleStmt')
            tei_title_s = etree.SubElement(tei_titlestmt, 'title', level='s')
            tei_title_s.text = 'Auden in Austria Digital'
            tei_title_a = etree.SubElement(tei_titlestmt, 'title', level='a')
            tei_title_a.text = row['title']
            tei_author = etree.SubElement(tei_titlestmt, 'author', ref=row['uri'])
            tei_author_name = etree.SubElement(tei_author, 'persName', ref=row['entity'])
            tei_author_name.text = row['author']
            tei_editor = etree.SubElement(tei_titlestmt, 'editor')
            tei_editor_tf = etree.SubElement(tei_editor, 'name', ref='https://orcid.org/0000-0002-3997-5193')
            tei_editor_tf.set('{http://www.w3.org/XML/1998/namespace}id', 'tfruehwirth')
            tei_editor_tf.text = 'Fruehwirth, Timo'
            tei_editor_sm = etree.SubElement(tei_editor, 'name', ref='https://orcid.org/0000-0002-2915-5888')
            tei_editor_sm.set('{http://www.w3.org/XML/1998/namespace}id', 'smayer')
            tei_editor_sm.text = 'Mayer, Sandra'
            tei_funder = etree.SubElement(tei_titlestmt, 'funder')
            tei_funder_name = etree.SubElement(tei_funder, 'name', ref='https://d-nb.info/gnd/2054142-9')
            tei_funder_name.text = 'Austrian Science Fund (FWF)'
            tei_funder_address = etree.SubElement(tei_funder, 'address')
            tei_funder_street = etree.SubElement(tei_funder_address, 'street')
            tei_funder_street.text = 'Georg-Coch-Platz 2'
            tei_funder_zip = etree.SubElement(tei_funder_address, 'postCode')
            tei_funder_zip.text = '1010'
            tei_funder_city = etree.SubElement(tei_funder_address, 'settlement')
            tei_funder_city.text = 'Vienna'
            tei_funder_country = etree.SubElement(tei_funder_address, 'country', key='AT')
            tei_funder_country.text = 'Austria'
            tei_funder_idno = etree.SubElement(tei_funder, 'idno', type='DOI')
            tei_funder_idno.text = '10.55776/P37139'
            tei_pubstmt = etree.SubElement(tei_filedesc, 'publicationStmt')
            tei_publisher = etree.SubElement(tei_pubstmt, 'publisher', ref='https://d-nb.info/gnd/1226158307')
            tei_publisher.text = 'Austrian Centre for Digital Humanities and Cultural Heritage (ACDH-CH)'
            tei_sourcedesc = etree.SubElement(tei_filedesc, 'sourceDesc')
            tei_msdesc = etree.SubElement(tei_sourcedesc, 'msDesc')
            tei_msid = etree.SubElement(tei_msdesc, 'msIdentifier')
            tei_repo = etree.SubElement(tei_msid, 'repository')
            tei_repo.text = row['repository']
            tei_coll = etree.SubElement(tei_msid, 'collection')
            tei_coll.text = row['collection']
            tei_idno = etree.SubElement(tei_msid, 'idno')
            tei_idno.text = row['idno']
            tei_editionstmt = etree.SubElement(tei_filedesc, 'editionStmt')
            tei_edition = etree.SubElement(tei_editionstmt, 'edition')
            tei_title = etree.SubElement(tei_edition, 'title', level='a')
            tei_title.text = row['title']
            tei_respstmt1 = etree.SubElement(tei_editionstmt, 'respStmt')
            tei_resp1 = etree.SubElement(tei_respstmt1, 'resp')
            tei_resp1.text = 'Data model, transcription, markup, commentary'
            tei_resp1_name1 = etree.SubElement(tei_resp1, 'name', ref='https://orcid.org/0000-0002-3997-5193', sameAs='tfruehwirth')
            tei_resp1_name2 = etree.SubElement(tei_resp1, 'name', ref='https://orcid.org/0000-0002-2915-5888', sameAs='smayer')

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
