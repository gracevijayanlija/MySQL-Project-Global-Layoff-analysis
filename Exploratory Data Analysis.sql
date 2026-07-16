-- Exploratory Data Analysis

select *
from layoffs_staging2;

# finding maximum no of laid off happened
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

#company that did maximum lay off
select company
from layoffs_staging2
where total_laid_off = 12000;

#companies that completely went under
select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

#looking at the date range of layoff
select min(`date`), max(`date`)
from layoffs_staging2;

#which industries had laid off
select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

#which countries had maximum lay off
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

#dates of layoffs
select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;   #gives layoff number of individual dates.
#for yearly numbers,
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc; 

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc; 

#progression of the layoff(rolling sum)
select substring(`date`, 1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `month`
order by 1 asc;
#doing rolling sum using CTE
with Rolling_Total as
(
select substring(`date`, 1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off
,sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

#ranking companies based on no of laid off (using CTE)
WITH Company_Year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
)
select *, 
dense_rank() over(partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null
order by ranking asc;

WITH Company_Year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as
(select *, 
dense_rank() over(partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null
)
select *
from Company_Year_Rank
where ranking <= 5;
