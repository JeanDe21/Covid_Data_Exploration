use Portfolio

-- checking imported data
select *
from coviddeaths

select *
from covidvaccinations
order BY 1,3

select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths
order by 1,2

-- looking at total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 as DeathPercentage
from coviddeaths
where location like '%states%'
order by 1,2 

-- population percentage got covid

select location, date,population, total_cases, (total_cases/population)* 100 as PercentPopInfented
from coviddeaths
where location like '%states%'
order by 1,2 

-- countries with highest infenction compare to population.

select location, population, max(total_cases) as highestinfectedcount, max(total_cases/population)* 100 as PercentPopInfented
from coviddeaths
--where location like '%states%'
group by location, population
order by PercentPopInfented desc

-- countries with highest death count per population

select location, MAX(total_deaths) as totaldeathcount
from coviddeaths
where continent is not null
group by location
order by totaldeathcount desc

use portfolio

select *
from coviddeaths
join covidvaccinations	s
   on coviddeaths.date = covidvaccinations.date
   and coviddeaths.location = covidvaccinations.location
   
   -- looking at total population vs vaccinations by joining both deaths and vaccinations tables.
   -- you cant use a column you just created for calculation. you need to use CTE or TEMP TABLE

/* with PopvsVac (continent, location, date, population, new_vaccinations,rollingpeoplevaccinated)
as ( 
    select coviddeaths.continent, coviddeaths.location, cast(coviddeaths.date as date) as date, coviddeaths.population, covidvaccinations.new_vaccinations,
    sum(CONVERT(INT,covidvaccinations.new_vaccinations)) over (partition by coviddeaths.location order by coviddeaths.location, date) as rollingpeoplevaccinated
    from coviddeaths 
    join covidvaccinations	
     on coviddeaths.date = covidvaccinations.date
     and coviddeaths.location = covidvaccinations.location
   where coviddeaths.continent is not null
-- order by 2,3 
)
select *, (rollingpeoplevaccinated/population)*100
from PopvsVac

drop table if exists PercentagePopVaccinated
create table PercentagePopVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime, 
population numeric,
new_vaccinations numeric, 
rollingpoeplevaccinated numeric
)

insert into PercentagePopVaccinated
select coviddeaths.continent, coviddeaths.location, cast(coviddeaths.date as date) as date, coviddeaths.population, covidvaccinations.new_vaccinations, 
sum(CONVERT(INT,covidvaccinations.new_vaccinations)) over (partition by coviddeaths.location order by coviddeaths.location, coviddeaths.date) as rollingpeoplevaccinated
from coviddeaths 
join covidvaccinations	
  on coviddeaths.date = covidvaccinations.date
  and coviddeaths.location = covidvaccinations.location
where coviddeaths.continent is not null
-- order by 2,3 

select *, (rollingpeoplevaccinated/population)*100
from PercentagePopVaccinated */