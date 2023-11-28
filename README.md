# Lexical-Analyzer-Compilation-Listing-Code-Generator

# General Usage
- From the root directory you'll run:
```
docker build -t code-list:latest -f docker/Dockerfile .
```
- Then you'll run:
```
docker run --name code-list -v <location_to_root_folder>:/code-list -it code-list
```
- Once inside container and ready to test:
```
./compile < <filename>.txt
```
