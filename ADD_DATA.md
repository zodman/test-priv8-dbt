
## For adding data.

To add data to the dbt_project, it is important to note that  it is a very dynamic process and requires the union of all added sources.

This means that any new source data added must have compatibility fields with the

`mcdm_paid_ads_basic_performance_structure.mcdm_field_name` 

and 

`mcdm_paid_ads_basic_performance_structure.mcdm_field_value_type`.


### from a seed

To add a CSV to the `seed/` directory, run `dbt seed` to seed the data into the DWH. 



### Add the resource:


To add a new resource, go to `models/sources.yaml` and add a new entry behind the entry `source_data`:

```
#for the case of  seed/src_custom.csv
   - name: custom
     identifier: src_custom
     columns:
       - name: channel
         tests:
           - dbt_expectations.expect_column_to_exist
       - name: date
         tests:
           - dbt_expectations.expect_column_to_exist
           - not_null
           - dbt_expectations.expect_column_values_to_be_in_type_list:
               column_type_list: [date, datetime]


```

** **It's important add the test because that fields are required for the report**

Now you should check if the new source pass the test:

```
dbt test
```

Then add the new resource to the `sources_list` in `dbt_project.yml`

```
vars:
  sources_list:
    - twitter
    - tiktok
    - bing
    - facebook
    - custom # new resource
```

If needed remap some fields, You need to map the `column_destination: column_origin`

For example the `total_conversations` of the new resources are stored
in the `conver` column then need to:


```
  remap_fields:
    custom:
   # column_destination: column_origin
      total_conversions: conver
````

That's it. Execute run

```

dbt run 

```

