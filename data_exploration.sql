  -- Show the percent of population got Covid
SELECT
  location,
  date,
  population,
  total_cases,
  (total_cases/population)*100 AS percentage_population_infected
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
ORDER BY
  location,
  date
  -- Looking at Countries with Highest Infection Rate compared to Population
SELECT
  location,
  population,
  MAX(total_cases) AS highest_infection_count,
  MAX(total_cases/population)*100 AS percent_population_infected
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  location,
  population
ORDER BY
  percent_population_infected DESC
  -- Showing Countries with Highest Death Count per Population
SELECT
  location,
  MAX(CAST(total_deaths AS int)) AS total_death_count
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  location
ORDER BY
  total_death_count DESC
  -- Looking at Continent
SELECT
  continent,
  MAX(CAST(total_deaths AS int)) AS total_death_count
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  continent
ORDER BY
  total_death_count DESC
  -- Showing the continent with the highest death count per population
SELECT
  continent,
  MAX(CAST(total_deaths AS int)) AS total_death_count
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  continent
ORDER BY
  total_death_count DESC
  -- Global numbers
SELECT
  location,
  date,
  population,
  total_cases,
  (total_cases/population)*100 AS percentage_population_infected
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths`
WHERE
  continent IS NOT NULL
ORDER BY
  location,
  date
  -- Looking at Total Population vs Vaccinations
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths` dea
JOIN
  `elite-conquest-368211.portfolio_project.covid_vaccinations` vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent IS NOT NULL
ORDER BY
  dea.location,
  dea.date
  -- Createing VIEW to store data for futher visualisations
CREATE VIEW
  percent_population_vaccinated AS
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM
  `elite-conquest-368211.portfolio_project.covid_deaths` dea
JOIN
  `elite-conquest-368211.portfolio_project.covid_vaccinations` vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent IS NOT NULL