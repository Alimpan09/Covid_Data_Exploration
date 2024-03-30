CREATE database Test;
USE Test;
select * from test.coviddeaths
order by 3,4;

select * from test.covidvaccinations
order by 3,4;

Select Location, date, total_cases, new_cases, total_deaths, population
From test.coviddeaths
Where continent is not null
order by 1,2;

-- TOTAL CASES VS TOTAL DEATHS

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From test.coviddeaths
WHERE continent is not null 
order by 1,2;

-- TOTAL CASES VS POPULATION

Select Location, date, total_cases,population, (total_cases/population)*100 as CasesPercentage
From test.coviddeaths
WHERE continent is not null 
order by 1,2;

-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From test.coviddeaths
Group by Location, Population
order by PercentPopulationInfected desc;

-- Countries with Highest Death Count per Population

Select Location, MAX(total_deaths) as TotalDeathCount
From test.coviddeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc;

-- Showing contintents with the highest death count per population

Select continent, MAX(Total_deaths) as TotalDeathCount
From test.coviddeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc;

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From test.coviddeaths
where continent is not null 
order by 1,2;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From test.coviddeaths dea
Join test.covidvaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;



