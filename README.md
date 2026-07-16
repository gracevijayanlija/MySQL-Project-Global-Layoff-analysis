# Global Layoff Trends Analysis (2020–2023) — MySQL

Analyzed 2,300+ layoff records to uncover patterns across industries, countries, and funding stages, covering the onset of COVID-19 through early 2023.

**Tools:** MySQL Workbench (CTEs, Window Functions, Self-Joins, String Manipulation)

**What's in the analysis:**
- Total and % layoffs by company and industry
- Geographic distribution by country
- Year-over-year and monthly progression of job losses
- Company rankings by layoff volume within specific years
- Impact of funding stage (Post-IPO, Series A, etc.) on layoff numbers

**Data cleaning:**
- Removed duplicates using `ROW_NUMBER()` in a CTE, staged into a clean table
- Standardized inconsistent labels (e.g. "Crypto" / "Cryptocurrency"), trimmed whitespace, fixed country name typos
- Converted text-based dates to SQL `DATE` format
- Filled missing industry values via self-join on matching company names
- Removed rows where both total and % layoffs were null

**Key insights:**
- Largest single event: 12,000 layoffs by one company in a single day
- Consumer and Retail were the hardest-hit sectors
- United States led all countries with 256,000+ total layoffs
- Q1 2023 alone saw 125,000 layoffs, a sharp acceleration from 2022
- Post-IPO tech giants (Amazon, Google, Meta) topped the rankings by total layoffs

**Files:** `Data cleaning project.sql` (data transformation) · `Exploratory Data Analysis.sql` (trend analysis, rolling totals)
