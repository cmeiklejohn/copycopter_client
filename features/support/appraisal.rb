module AppraisalHelper
  BUNDLE_ENV_VARS = %w(RUBYOPT BUNDLE_PATH BUNDLE_BIN_PATH BUNDLE_GEMFILE)
  ORIGINAL_BUNDLE_VARS = Hash[ENV.select{ |key,value| BUNDLE_ENV_VARS.include?(key) }]

  def setup_appriasal_gemfile
    ENV['BUNDLE_GEMFILE'] = File.join(Dir.pwd, ENV['BUNDLE_GEMFILE'])
  end

  def reset_original_bundler_variables
    ORIGINAL_BUNDLE_VARS.each_pair do |key, value|
      ENV[key] = value
    end
  end

  def reset_bundler_variables
    BUNDLE_ENV_VARS.each do |key|
      ENV[key] = nil
    end
  end
end

World(AppraisalHelper)

Before do
  setup_appriasal_gemfile
end

After do
  reset_original_bundler_variables
end

When /^I reset Bundler environment variable$/ do
  reset_bundler_variables
end
