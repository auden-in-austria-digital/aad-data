import csv  # import csv module
from lxml import etree  # import etree functionality from lxml library
from datetime import date  # import date functionality from datetime module

tei_namespace = 'http://www.tei-c.org/ns/1.0'  # define TEI namespace
xsi_namespace = 'http://www.w3.org/2001/XMLSchema-instance'  # define Schema Instance namespace
xml_base = 'https://id.acdh.oeaw.ac.at/auden-in-austria-digital'  # define XML base

docs_list = []  # create list of document IDs

with open('./metadata/csv/output_doc_id.csv', 'r', newline='', encoding='utf-8') as csv_file:  # open input file in read mode, disable universal newlines mode, specify text as UTF-8-encoded
    table = csv.DictReader(csv_file, delimiter=',', quotechar='"')  # read CSV contents and parse rows into dictionaries

    for row in table:

        # target data common to all rows related to same document ID
        if row['doc'] not in docs_list:

            xml_id = f"aad-transcript__{row['doc']}"  # define XML ID

            root = etree.Element('TEI', nsmap={None: tei_namespace, 'xsi': xsi_namespace})  # add root element
            root.set('{http://www.w3.org/XML/1998/namespace}id', xml_id)  # define root xml:id attribute
            root.set('{http://www.w3.org/XML/1998/namespace}base', xml_base)  # define root xml:base attribute

            # add teiHeader node
            tei_header = etree.SubElement(root, 'teiHeader')
            tei_filedesc = etree.SubElement(tei_header, 'fileDesc')
            tei_titlestmt = etree.SubElement(tei_filedesc, 'titleStmt')
            tei_title_s = etree.SubElement(tei_titlestmt, 'title', level='s')
            tei_title_s.text = 'Auden in Austria Digital (AAD)'
            tei_title_a = etree.SubElement(tei_titlestmt, 'title', level='a')
            tei_title_a.text = row['title']
            tei_author = etree.SubElement(tei_titlestmt, 'author', ref=row['author-uri'])
            tei_author.text = row['author']
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
            tei_editionstmt = etree.SubElement(tei_filedesc, 'editionStmt')
            tei_edition = etree.SubElement(tei_editionstmt, 'edition')
            tei_title = etree.SubElement(tei_edition, 'title', level='a')
            tei_title.text = row['title']
            tei_interpgrp = etree.SubElement(tei_edition, 'interpGrp')
            tei_interp = etree.SubElement(tei_interpgrp, 'interp')
            tei_interpdesc = etree.SubElement(tei_interp, 'desc')
            tei_interprespons = etree.SubElement(tei_interp, 'respons', resp='#smayer #tfruehwirth', locus='value')
            tei_interpcertainty = etree.SubElement(tei_interp, 'certainty', locus='value')
            tei_respstmt1 = etree.SubElement(tei_editionstmt, 'respStmt')
            tei_resp1 = etree.SubElement(tei_respstmt1, 'resp')
            tei_resp1.text = 'Data model, transcription, TEI/XML markup, commentary'
            tei_resp1_name1 = etree.SubElement(tei_respstmt1, 'name', sameAs='#tfruehwirth')
            tei_resp1_name2 = etree.SubElement(tei_respstmt1, 'name', sameAs='#smayer')
            tei_respstmt2 = etree.SubElement(tei_editionstmt, 'respStmt')
            tei_resp2 = etree.SubElement(tei_respstmt2, 'resp')
            tei_resp2.text = 'ODD/RNG TEI/XML schema'
            tei_resp2_name1 = etree.SubElement(tei_respstmt2, 'name', ref='https://orcid.org/0000-0002-9575-9372')
            tei_resp2_name1.set('{http://www.w3.org/XML/1998/namespace}id', 'pandorfer')
            tei_resp2_name1.text = 'Andorfer, Peter'
            tei_resp2_name2 = etree.SubElement(tei_respstmt2, 'name', ref='https://orcid.org/0000-0002-0636-4476')
            tei_resp2_name2.set('{http://www.w3.org/XML/1998/namespace}id', 'delsner')
            tei_resp2_name2.text = 'Elsner, Daniel'
            tei_resp2_name3 = etree.SubElement(tei_respstmt2, 'name', ref='https://orcid.org/0000-0001-6104-7484')
            tei_resp2_name3.set('{http://www.w3.org/XML/1998/namespace}id', 'ahechtl')
            tei_resp2_name3.text = 'Hechtl, Angelika'
            tei_pubstmt = etree.SubElement(tei_filedesc, 'publicationStmt')
            tei_publisher = etree.SubElement(tei_pubstmt, 'publisher', ref='https://d-nb.info/gnd/1226158307')
            tei_publisher.text = 'Austrian Centre for Digital Humanities (ACDH)'
            tei_pubplace = etree.SubElement(tei_pubstmt, 'pubPlace', ref='https://d-nb.info/gnd/4066009-6')
            tei_pubplace.text = 'Vienna'
            tei_pubdate = etree.SubElement(tei_pubstmt, 'date')
            tei_pubdate.set('when-iso', '2027')
            tei_pubdate.text = '2027'
            tei_availability = etree.SubElement(tei_pubstmt, 'availability')
            tei_licence = etree.SubElement(tei_availability, 'licence', target='https://creativecommons.org/licenses/by/4.0/')
            tei_pubidno = etree.SubElement(tei_pubstmt, 'idno', type='Handle')
            tei_seriesstmt = etree.SubElement(tei_filedesc, 'seriesStmt')
            tei_seriestitle = etree.SubElement(tei_seriesstmt, 'title', level='s')
            tei_seriestitle.text = tei_title_s.text
            tei_sourcedesc = etree.SubElement(tei_filedesc, 'sourceDesc')
            tei_listwit = etree.SubElement(tei_sourcedesc, 'listWit')
            tei_witness = etree.SubElement(tei_listwit, 'witness', n='1')
            tei_msdesc = etree.SubElement(tei_witness, 'msDesc')
            tei_msid = etree.SubElement(tei_msdesc, 'msIdentifier')
            tei_repo = etree.SubElement(tei_msid, 'repository', ref=row['repository-uri'])
            tei_repo.text = row['repository']
            tei_coll = etree.SubElement(tei_msid, 'collection')
            tei_coll.text = row['collection']
            tei_idno = etree.SubElement(tei_msid, 'idno')
            tei_idno.text = row['idno']
            tei_physdesc = etree.SubElement(tei_msdesc, 'physDesc')
            tei_objectdesc = etree.SubElement(tei_physdesc, 'objectDesc')
            tei_supportdesc = etree.SubElement(tei_objectdesc, 'supportDesc')
            tei_support = etree.SubElement(tei_supportdesc, 'support')
            tei_watermark = etree.SubElement(tei_support, 'watermark')
            tei_handdesc = etree.SubElement(tei_physdesc, 'handDesc')
            tei_handnote = etree.SubElement(tei_handdesc, 'handNote')
            tei_typedesc = etree.SubElement(tei_physdesc, 'typeDesc')
            tei_typenote = etree.SubElement(tei_typedesc, 'typeNote')
            tei_history = etree.SubElement(tei_msdesc, 'history')
            tei_origin = etree.SubElement(tei_history, 'origin')
            tei_origdate = etree.SubElement(tei_origin, 'origDate')
            tei_origdate.set('notBefore-iso', row['notBefore-iso'])
            tei_origdate.set('notAfter-iso', row['notAfter-iso'])
            tei_origplace = etree.SubElement(tei_origin, 'origPlace', ref=row['place-uri'])
            tei_origplace.text = row['place']
            tei_xenodata = etree.SubElement(tei_header, 'xenoData')
            tei_rdf = etree.SubElement(tei_xenodata, '{http://www.w3.org/1999/02/22-rdf-syntax-ns#}RDF', nsmap={'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'})
            tei_encodingdesc = etree.SubElement(tei_header, 'encodingDesc')
            tei_listprefixdef = etree.SubElement(tei_encodingdesc, 'listPrefixDef')
            tei_prefixdef = etree.SubElement(tei_listprefixdef, 'prefixDef', ident='acdh', matchPattern='(.+)', replacementPattern='https://id.acdh.oeaw.ac.at/auden-in-austria-digital/$1')
            tei_profiledesc = etree.SubElement(tei_header, 'profileDesc')
            tei_langusage = etree.SubElement(tei_profiledesc, 'langUsage')
            tei_language = etree.SubElement(tei_langusage, 'language', ident='')
            tei_revisiondesc = etree.SubElement(tei_header, 'revisionDesc', status='draft')
            tei_change = etree.SubElement(tei_revisiondesc, 'change', who='#tfruehwirth')
            iso_date = date.today().isoformat()
            tei_change.set('when-iso', iso_date)
            tei_change.text = 'TEI/XML template populated with csv2xml.py'

            # add facsimile node
            tei_facsimile = etree.SubElement(root, 'facsimile')

            # add text node
            tei_text = etree.SubElement(root, 'text')
            tei_body = etree.SubElement(tei_text, 'body')
            tei_div1 = etree.SubElement(tei_body, 'div', type='transcription')
            tei_div1.set('{http://www.w3.org/XML/1998/namespace}id', f"transcription_aad_{row['doc']}")
            tei_div1.set('{http://www.w3.org/XML/1998/namespace}lang', '')
            tei_div2 = etree.SubElement(tei_div1, 'div')

            file_name = f"./data/xml/tmp/{xml_id}_tmp.xml"  # define output file name

            docs_list.append(row['doc'])  # append current document ID to list of document IDs

        # target row-specific data
        img_url = f"https://iiif.acdh.oeaw.ac.at/aad/aad_{row['img']}/"
        tei_dimensions = etree.SubElement(tei_support, 'dimensions', unit="mm", facs=img_url) # add elements in teiHeader node
        tei_width = etree.SubElement(tei_dimensions, 'width')
        tei_width.text = row['width']
        tei_height = etree.SubElement(tei_dimensions, 'height')
        tei_height.text = row['height']
        tei_surface = etree.SubElement(tei_facsimile, 'surface', ulx='0', uly='0', lrx=row['lrx'], lry=row['lry'])  # add elements in facsimile node
        tei_graphic = etree.SubElement(tei_surface, 'graphic', url=img_url)
        tei_pb = etree.SubElement(tei_div1, 'pb', facs=img_url, ed=row['ed'], type=row['type'])  # add element in text node

        with open(file_name, 'w') as xml_file:  # open/create output XML file in write mode
            xml_content = etree.tostring(root, encoding='utf-8', xml_declaration=True, pretty_print=True).decode('utf-8')  # convert XML ElementTree structure to UTF-8-encoded byte string; add XML declaration, indentation, and line breaks; decode UTF-8 byte string into Unicode string
            lines = xml_content.split('\n', 1)  # split string at first newline; pass strings to list
            # list schema references after XML declaration
            xml_models = [
                '<?xml-model href="../aad-validation.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>',
                '<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>',
                '<?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml"\n\tschematypens="http://purl.oclc.org/dsdl/schematron"?>'
            ]
            xml_content = lines[0] + '\n' + '\n'.join(xml_models) + '\n' + lines[1]  # insert schema references after XML declaration
            xml_file.write(xml_content)
