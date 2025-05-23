-- Data Cleaning --

select * from layoffs;

-- remove duplicates --
-- standardize the data --
-- null values or blank values --
-- remove any columns or rows--

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

select *,
row_number() over(
partition by company,industry,total_laid_off,percentage_laid_off,`date`) as rows_num
from layoffs_staging;


with Duplicate_cte as 
(
select *,
row_number() over(
partition by 
company,location,industry,stage,country,funds_raised_millions,percentage_laid_off,`date`) as rows_num
from layoffs_staging
)
select * 
from Duplicate_cte
where rows_num > 1;

select * 
from layoffs_staging
where company = 'casper';

select * from layoffs_staging2;

insert layoffs_staging2
select *,
row_number() over(
partition by 
company,location,industry,stage,country,funds_raised_millions,percentage_laid_off,`date`) as rows_num
from layoffs_staging;

select * from layoffs_staging2
where rows_num > 1;

delete
from layoffs_staging2
where rows_num > 1;

select * from layoffs_staging2;

 -- standardizing data --
 
 select company,trim(company)
 from layoffs_staging2;
 
 update layoffs_staging2
 set compamy = trim(company);
 
 select *
 from layoffs_staging2
 where industry like 'Crypto%';
 
 update layoffs_staging2
 set industry = 'Crypto'
 where industry like 'Crypto%';
 
 select distinct country
 from layoffs_staging2
 order by 1;
 
 select * from layoffs_staging2
 where country = 'United states.';
 
 update layoffs_staging2
 set country = 'United States'
 Where country = 'United States.';
 
 select `date`,
 str_to_date(`date`, '%m/%d/%Y')
 from layoffs_staging2;
 
 select * from layoffs_staging2;
 
 update layoffs_staging2
 set `date` =  str_to_date(`date`, '%m/%d/%Y');
 
 alter table layoffs_staging2
 modify column `date` date;
 
 select *
 from layoffs_staging2
 where industry is null
 or industry = '';
 
select *
from layoffs_staging2
where company = "Bally's Interactive";

update layoffs_staging2
set industry = null
where industry = '';

select t1.industry , t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

select * 
 from layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null;

delete
 from layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null;

select * 
 from layoffs_staging2;

alter table layoffs_staging2
drop column rows_num;

select * from layoffs_staging2;





