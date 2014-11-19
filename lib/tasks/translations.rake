namespace :localeapp do
  #
  # This task scans all views of the project for static translations keys and sends missing keys to localeapp.
  #
  # Note :
  #   Only static keys will be detected.
  #   Only translations calls using t("key_name") or t('key_name') (WITH parentheses) will be detected.
  task :scan_and_send => :environment do
    # Appends view name if key starts by '.'
    def format_view_filename(key, view_name)
      return key unless key.starts_with?(".")

      view_name.slice(10..-6-(File.extname(view_name).size)).gsub("/_", "/").gsub("/", ".") + key
    end

    translations_keys = []

    Dir.glob("app/**/*.{erb,haml,slim}").each do |view|
      puts "Reading: " + view

      File.readlines(view).each do |line|
        raw_translations_keys = line.scan(/ t\(\"([0-9a-zA-Z\._]+)\"\)/).flatten + line.scan(/ t\(\'([0-9a-zA-Z\._]+)\'\)/).flatten
        translations_keys.concat(raw_translations_keys.map { |t| format_view_filename(t, view) })
      end
    end

    puts
    puts "All translations keys found:"
    puts translations_keys

    puts
    puts "Trying to translate all keys..."
    translations_keys.each do |key|
      I18n.t(key)
    end

    puts
    puts "Missing translations:"
    puts Localeapp.missing_translations.to_send.map { |k| k[:key] }

    puts
    puts "Sending translations..."
    Localeapp.sender.post_missing_translations
    puts "Done..."
  end
end