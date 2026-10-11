# Repository maintenance tools

The `scripts/` folder contains checks that help keep the API directory consistent and catch broken links before changes are proposed.

## Folder map

```text
scripts/
├── github_pull_request.sh     # local checks while preparing a change
├── requirements.txt           # Python dependencies
├── tests/                     # automated tests
└── validate/                  # README formatting and link checks
```

## Set up

Install [Python 3](https://www.python.org/). From the repository root, install the packages needed by the checks:

```bash
python -m pip install -r scripts/requirements.txt
```

## Check the directory

Run these commands from the repository root.

Check README table formatting:

```bash
python scripts/validate/format.py README.md
```

Check README links:

```bash
python scripts/validate/links.py README.md
```

The full link pass can take a while because it visits external sites. To check duplicates without testing every URL, run:

```bash
python scripts/validate/links.py README.md -odlc
```

The `-odlc` flag is short for `--only_duplicate_links_checker`.

## Run the tests

Change into the `scripts/` directory first:

```bash
cd scripts
python -m unittest discover tests/ --verbose
```

To run just one group of tests, add a pattern:

```bash
python -m unittest discover tests/ --verbose --pattern "test_validate_format.py"
python -m unittest discover tests/ --verbose --pattern "test_validate_links.py"
```
