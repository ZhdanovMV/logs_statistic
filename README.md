# App Description
Page Statistic app allows you to parse webserver log file and get statistic about most visited pages and pages with most unique views sorted from top to bottom.

# How to install
Install Ruby, clone the repo and execute
```bash
bundle install
chmod +x logs_statistic.rb 
```

# How to run app
```bash
./logs_statistic.rb webserver.log
```
You may replace `webserver.log` with your own logs file.

# How to run specs
```bash
bundle exec rspec
```

# Approach Description
App is splitted between several files with its own responsibilities.

Entrypoint is `logs_statistic.rb` that receives log_file_path as an argument.

`utilities/file_reader.rb` will try to open this file and read its content line by line in lazy mode.

Each line is being parsed by `logs/parser.rb`, which also call dry-validation contract to validate log record.

Then `logs/ip_saver.rb` will save IP address to the file with a name of the visited page. This way we won't need to keep all the records in RAM to be able to filter and sort records.

`page_statistics/visit_counter.rb` is reading all created files line by line and saving visits and unique views statistic for each page.

After that `page_statistics/sorter.rb` can easily sort page statistics by visits and unique views.

`page_statistics/formatter.rb` formats this statistic to be printed in a command line.

`utilities/command_line_printer.rb` simply outputs this statistic to the user in a command line.

# Possible improvements
* There are uncountable possibilities to refactor and improve the app.
* We could optimize work with unique views.
* OpenStruct log records could be replaced by LogRecordEntity if we had enough business logic to do so.
* For dependency injection we could use dry-container + dry-auto_inject.
* In specs we could use factories, ffaker for fake data generation, shared_examples and shared_context. And we could separate unit and integration specs.
* yard docs
