## About

The purpose of this project to take full harvests of as many Ukrainian OAI-PMH repository servers (metadata and source files) as possible. Refer [https://github.com/sucho-oai](https://github.com/sucho-oai) for all the repositories harvested. 1 Git repository per OAI-PMH repository endpoint.

Currently over 800 Ukrainian OAI endpoints have been documented, and harvests started

### What is a OAI-PMH repository?

OAI-PMH is an interoperability protocol used by archival and document repository servers. 

### What is a document repository??

Libraries, universities, institutions, reasearch organisations, academic publishers and more store, manage and publish their important documents - suchs as jounrals, thesis, research, iamges etc.. in doucment repository server - such as ePrints, OJS or Dspace.

Repositories harvested include (but not limited to) academic journals, thesis PDFs, conference papers, images/photos, maps, scanned paintings and historical phtos - predominently from libraries (Univerities, regional, government, national and research), galleries, museums, government departments etc...

### Why? 

With the intent that if a Ukrainian repository is taken offline - it can be rebuild using these source files.

Repository servers from the various Ukrainian organisation contain a huge collection of the knowledge, history and digital artifacts of Ukraines cultural heritage.

Should anything happen to the physical entity - such as a library or gallery being destroyed, digital copies of their content is avialable in their document repositories. Should these digital copies become inaccessible (either servers physically destroyed or offline) this project (as well as [SUCHO.org](https://sucho.org) and the [Internet Archive](https://archive.org)) aim to have copies of the source OAI data and files.

## SUCHO

This project and repositories align with the [SUCHO.org](https://sucho.org) Saving Ukrainian Cultural Heritage Online project. SUCHO is doing an AMAZING job archiving to the [Internet Archive](https://archive.org) Ukraines curltural hertiage (libraries, galleries, musuems etc..) web site as possible as quickly as possible. It's focus is to crawl and archive Ukraines web pages in WACZ format - so they will be availble in perpetuity. If you are a cultural heritage profesional please consider volunteering.

## Where are we at?

This project has 4 parts:

 * 1: Archive as many Ukrainian OAI-PMH servers as possible and make the source OAI data avilable publically in Git
 * 2: Provide a single xml file per metadataPrefix/format per repository via our CDN for easy viewing/downloading of a full repository
 * 3: Use SUCHOs OAI file downloader scripts to harvest as many of the item files (PDFs etc..) that are linked in the OAI data
  * 3a: Publish the item files publically to an S3/B2 bucket and via the CDN
  * 3b: Publish the item files directly to the Internet ARchive or SUCHO - whichever is appropriate
 * 4: Transform and publish this data and files back to SUCHO in a format best suited to their processes

Parts 1 and 2 are currently in progress

## Tell me more about OAI-PMH

OAI-PMH is a standard which most academic and archival software repositores use for interoperability.

This projects focus is on OAI-PMH, as in the OAI data is the full metadata for the repository items and links to the item file - be that MARC, Dublin Core, MARC XML or other.

This metadata can be imported back into a new repository if and when requuired.

## Why Metha ?

Metha is a fantasic suite of oai tools that include harvesting (incrementaly and full), viewing, querying, and inspecting OAI data. Metha saves the OAI-PMH data in gzipped xml files in batches of records - which makes it easy to store in Git. 

For convienciance I have used `metha-cat` to create 1 big xml file per metadataPreifx/format per oai endpoint and uploaded these to BackBlaze B2 (simialr to AWS S3) and available via the CloudFlare CDN - links provided in each git repository README. These files can be too large for Git repositories.

## Example OAI file

Below is an example of the data stored in the OAI file - this one shows DC (Dublin Core) with the link to the soruce item file highlighted. These item files beed to be downloaded and stored as a seperate process

![DC OAI sample](https://raw.githubusercontent.com/sucho-oai/admin/master/dc-example.png)


### Requirements to run the harvesting scripts etc..

Setup:

 * metha
 * git
 * rsync
 * go
 * b2 client if you wish to upload / can be replaced with an s3 client
 * gh - this is the github cli app used to auto create and manange git repositories

Metha is available from [https://github.com/miku/metha](https://github.com/miku/metha) and can be easily installed with `go` using the below command

```go install -v github.com/miku/metha/cmd/...@latest```

Create a directory for Metha to store the OAI data and set a `METHA_DIR` environment variable

```export METHA_DIR=/home/justin/sucho/metha-dir```

The script `harvest.sh` has 2 inputs

 * -f (filename) the file name the list of OAI endpoints, hosts.txt is the default
 * -h (harvest) "yes" to harvest, "no" to no harvest - but to update all the git repositories

```https://docs.google.com/spreadsheets/d/1qkgIFZIvipqqJ80e2oyodAQVYedgBIq6GRtbGi16-eY/export?format=csv```

