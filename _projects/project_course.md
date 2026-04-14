---
title: Project Course
order: 5
description: >
  The pipeline runs on an HPC cluster using Dask for distributed task scheduling. A main script initializes a Dask scheduler that distributes data collection tasks across multiple workers, each running several parallel processes. These processes retrieve data from the Bluesky platform and process it in time-based batches. The collected data are then stored in Google Cloud storage for further analysis and long-term storage.
  
links:
  - name: Report
    url: /assets/pdf/data_extraction_report.pdf

---

