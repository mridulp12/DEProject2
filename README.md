# DEProject2
The goal of this project is to buildout a analytical databse model. 

## Architecture diagram
<img width="468" alt="Picture8" src="https://github.com/mridulp12/DEProject2/assets/140646057/a65a27f9-bc89-45ca-929c-da826c77653e">

1. Airbyte connection from Postgres to Snowflake including incremental extract.
   ![Picture1](https://github.com/mridulp12/DEProject2/assets/140646057/f28a79ff-9b20-4fcb-b410-a9884af3a669)

  2. Transformation using Snowflake SQL that includes 7+ transformation:
![Picture2](https://github.com/mridulp12/DEProject2/assets/140646057/c28f96d6-81b7-45c7-a0d9-1d206c3ff6ac)

3.Data Modeling: 2 fact table and multiple dim table along with OBT!
mg width="301" alt="Picture3" src="https://github.com/mridulp12/DEProject2/assets/140646057/5a17492c-7a6f-4884-82fb-8336d06c7155">
<img width="290" alt="Picture4" src="https://github.com/mridulp12/DEProject2/assets/140646057/e24f39f8-0f63-415d-8f89-8e8ecb36808d">

4. Semantic Modeling and Visualization. Was able to create connection and sync some data but still needs some debugging. Due to time constraint I couldn’t make it perfect.
   ![Picture5](https://github.com/mridulp12/DEProject2/assets/140646057/626b209b-3609-4b19-8480-2fd16323d4bb)
![Picture6](https://github.com/mridulp12/DEProject2/assets/140646057/e76169ef-378f-45ce-941c-9c1fa2d65ed5)

5. Should have gone dbt route but due to timing I had to go snowflake route because of my  comfort with the tool. Couldn’t figure out great expectations with snowflake – however next time I might use dbt for all the modeling. 

6. Didn’t have to do source – ref as I wasn’t using dbt but still had some dependencies for snowflake. More I went with the project clearer it became dbt >
![Picture7](https://github.com/mridulp12/DEProject2/assets/140646057/7b3d1aa8-84d4-41e4-8af1-da7495e201cd)
