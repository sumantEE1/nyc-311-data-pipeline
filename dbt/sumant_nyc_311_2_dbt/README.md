Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

Updated schema yml i.e. service_requests.yml
Moved/Created schema .yml file which is used as source
#schema name is the name of the source
Updated schema name in dbt profile yml from SUMANT_RAW to SUMANT
Removed example from profile yml for remolvin g example table and views 
Updated staging materialized to table for faster query
