## Project parent repositories

 * [https://github.com/sucho-oai](https://github.com/sucho-oai)
 * [https://sr.ht/~justinkelly/SUCHO/](https://sr.ht/~justinkelly/SUCHO/)

## About

This is a repository of the full harvest of the OAI-PMH server: OAI_URL using [metha](https://github.com/miku/metha)

The purpose of this project to take harvests of as many Ukrainian OAI-PMH repository servers (metadata and source files) as possible. Refer [https://github.com/sucho-oai](https://github.com/sucho-oai) for all the repositories harvested. 1 Git repository per OAI-PMH repository server or endpoint.

Repositories harvested include (but not limited to) academic journals, thesis PDFs, conference papers, images/photos, maps, scanned paintings and historical phtos - predominently from libraries (Univerities, regional, government, national and research), galleries, museums, government departments etc...

With the intent that if a Ukrainian repository is taken offline - it can be rebuild using these source files.

This project and repositories align with the [SUCHO.org](https://sucho.org) Saving Ukrainian Cultural Heritage Online project. SUCHO is doing an AMAZING job archiving to the [Internet Archive](https://archive.org) Ukraines curltural hertiage (libraries, galleries, musuems etc..) web site as possible as quickly as possible. It's focus is to crawl and archive Ukraines web pages in WACZ format - so they will be availble in perpetuity. If you are a cultural heritage profesional please consider volunteering.

This project has 4 parts:

 * 1: Archive as many Ukrainian OAI-PMH servers as possible and make the source OAI data avilable publically in Git
 * 2: Provide a single xml file per metadataPrefix/format per repository via our CDN for easy viewing/downloading of a full repository
 * 3: Use SUCHOs OAI file downloader scripts to harvest as many of the item files (PDFs etc..) that are linked in the OAI data
  * 3a: Publish the item files publically to an S3/B2 bucket and via the CDN
  * 3b: Publish the item files directly to the Internet ARchive or SUCHO - whichever is appropriate
 * 4: Transform and publish this data and files back to SUCHO in a format best suited to their processes

Parts 1 and 2 are currently in progress

### Why OAI-PMH

OAI-PMH is a standard which most academic and archival software repositores use for interoperability.

This projects focus is on OAI-PMH, as in the OAI data is the full metadata for the repository items and links to the item file - be that MARC, Dublin Core, MARC XML or other.

This metadata can be imported back into a new repository if and when requuired.

### Why Metha

Metha is a fantasic suite of oai tools that include harvesting (incrementaly and full), viewing, querying, and inspecting OAI data. 
Metha saves the OAI-PMH data in gzipped xml files in batches of records - which makes it easy to store in Git. 

For convienciance I have used `metha-cat` to create 1 big xml file per metadataPreifx/format per oai host and uploaded these to BackBlaze B2 (simialr to AWS S3) and available via the CloudFlare CDN - links below. These files can be too large for Git repositories.

## Details

OAI Server: 

 * OAI_URL

BackBlaze B2 public bucket:

 * Name: sucho-oai
 * URL:
https://f001.backblazeb2.com/file/sucho-oai/
 * S3 URL: https://sucho-oai.s3.us-west-001.backblazeb2.com/

Cloudflare CDN:

 * https://cdn.biblio.ai/file/sucho-oai/

Formats/metadataPrefixes harvested: oai_dc, oai_marc, marcxml, marc, mods,mets

## Complete OAI-PMH feed per format

* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/oai_dc.xml
* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/oai_marc.xml
* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/marcxml.xml
* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/marc.xml
* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/mods.xml
* https://cdn.biblio.ai/file/sucho-oai/GIT_REPO/mets.xml


**Note: If the above xmls files are blank, it means that the harvested repository was not publishing in this metadata format. If this repository is blank except for the README,- it means that the OAI-PMH server has not been fully harvested yet or isn unable to be harvested**
