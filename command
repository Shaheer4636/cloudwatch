

1. **Report UI: Add new HTML elements**
Extend the report layout with additional HTML components (sections, tables, callouts) to improve readability and structure.

2. **Report: Improve disclaimer section**
Rewrite and restyle the disclaimer to ensure clarity, consistency, and prominence, while also ensuring it renders correctly across all browsers.

3. **Report: Upgrade charts and footer**
Replace current graphs with clearer, unified chart styles and add a standardized footer (version, date, contact, links).

4. **Report: Implement HTML-to-PDF in Lambda**
Build a reliable HTML to PDF conversion step inside its own Lambda (or within existing Lambda if feasible), returning a downloadable PDF.

### Strata Account – Canary Setup

5. **Canary: Create and tune endpoint monitor**
   Stand up a CloudWatch Synthetics canary for the target endpoint, fine-tune timings, and validate results via initial manual monitoring.

6. **Canary: Provision S3 for artifacts and client reports**
   Create S3 buckets and folders, along with lifecycle policies, to store canary outputs and final client report PDFs; wire permissions and naming.

### Terraform Adjustments

7. **Terraform: Refactor to modular structure**
   Break current IaC into reusable Terraform modules with clear inputs/outputs, variables, and environment separation.

8. **Terraform: Package modules for reuse across clients**
   Generalize and document the modules so the same patterns can be replicated quickly for other client environments.
