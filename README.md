Public Formats
=========

This plugin exposes additional output formats for resource and digital object records in the public interface. It provides a convenient way to retrieve EAD, MARCXML, DC (etc.) representations of ArchivesSpace objects without requiring a staff account or authenticated / direct access to the backend. Optionally links can be added to the navigation sidebar.

Resources
-------------

Supported formats:

- EAD
- HTML
- MARCXML
- EAD PDF

Example urls for access:

```
http://some.archivesspace.edu/repositories/2/resources/1/format/ead
http://some.archivesspace.edu/repositories/2/resources/1/format/html
http://some.archivesspace.edu/repositories/2/resources/1/format/marcxml
http://some.archivesspace.edu/repositories/2/resources/1/format/ead_pdf

# example command to retrieve a record and save it to file:
curl "http://localhost:8081/repositories/2/resources/1/format/ead" > ead.xml
```

Digital Objects
-------------------

Supported formats:

- Dublin Core
- METS
- MODS

Example urls for access:

```
http://some.archivesspace.edu/repositories/2/digital_objects/35/format/dc
http://some.archivesspace.edu/repositories/2/digital_objects/35/format/mets
http://some.archivesspace.edu/repositories/2/digital_objects/35/format/mods

# example command to retrieve a record and save it to file:
curl "http://localhost:8081/repositories/2/digital_objects/1/format/dc" > dc.xml
```

Configuration
------------------

By default links to the formats are **not** added to the navigation sidebar. To add links edit:

```
vi /path/to/archivesspace/config/config.rb
```

And set (choosing the options you want to create public links for):

```
AppConfig[:public_formats_resource_links] = ["ead", "marcxml", "ead_pdf"]
AppConfig[:public_formats_digital_object_links] = ["dc", "mets", "mods"]
```

HTML
--------

The HTML output works by first requesting the EAD, then performing an XSLT transform on the XML. There are a couple of additional requirements for the html output to work:

- clone the ead xslt repository from `https://github.com/tingletech/ead_basic_xslt`
- install xsltproc
- set the path to xsltproc and the xslt repository in `public/plugin_init.rb`

Compatibility
-----------------

Tested with:

- ArchivesSpace v1.1.1
- ArchivesSpace v1.1.2
- ArchivesSpace v1.2.0

---
