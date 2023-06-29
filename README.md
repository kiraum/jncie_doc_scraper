# jncie_doc_scrapper

Just a document scrapper to download JNCIE (GilmoreGlobal), which was already reported to Juniper.

**This is an old script, and I don't plan to maintain, use at your own responsibility!**


### Requirements

imagemagick - Convert tool to create pdf from jpges.
cookies.txt - Generate a cookie file (using curl, lynx, firefox, chrome, ...) using valid credentials.

### Configuration

Configure desired document first page url:
````
first_page="https://jigsaw.gilmoreglobal.com/books/EDU-JNCIE-SP-1A-E/pages/531297623/content"
````

Configure document last page:
````
last_page=531299032
````

Configure output file:
````
output_file="jncie-sp_study_guide.pdf"
````
