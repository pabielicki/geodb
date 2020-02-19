# README
### Requirements:
  - docker
  - docker-compose
  - ipstack.com api key
### Setup:
  1. `docker-compose build --build-arg IPSTACK_API_KEY=YOUR_IPSTACK_API_KEY`
  2. `docker-compose up`
  3. `docker exec -it geodb_api_1 bundle exec rake db:create`
  4. `docker exec -it geodb_api_1 bundle exec rake db:migrate`

### Tests:
  - `docker exec -it geodb_api_1 rspec`

