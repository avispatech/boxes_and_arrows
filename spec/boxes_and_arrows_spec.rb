# frozen_string_literal: true
require 'fileutils'
RSpec.describe BoxesAndArrows do
  it 'has a version number' do
    expect(BoxesAndArrows::VERSION).not_to be nil
  end

  it 'renders quote process using Naive HTML Renderer' do
    steps = YAML.load_file('./spec/steps.yml')
    quote = steps['quote']
    output = BoxesAndArrows.render(steps: quote, method: :naive)
    puts output
  end

  it 'renders quote process using Nokogiri' do
    steps = YAML.load_file('./spec/steps.yml')
    quote = steps['quote']
    output = BoxesAndArrows.render(steps: quote)
    FileUtils.cp('./stylesheets/boxes_and_arrows.scss', '/tmp/baa.css')
    File.open('/tmp/steps.html', 'w') do |f|
      head = %(
        <!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="baa.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Bootstrap demo</title>
  </head>
  <body>
      )
      f.puts head
      f.puts output
      f.puts '</body></html>'
    end

    puts output
  end
end
