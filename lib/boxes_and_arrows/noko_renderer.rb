# frozen_string_literal: true

require 'nokogiri'

module BoxesAndArrows
  # Renders a Box and arrow representation of the a process using Nokogiri
  class NokoRenderer
    def initialize(steps: [], box_classes: [], step_classes: [], arrow_classes: [], grid_classes: [])
      @steps = steps
      @box_classes = box_classes
      @step_classes = step_classes
      @arrow_classes = arrow_classes
      @grid_classes = grid_classes
    end

    def div(doc, classlist, &block)
      classlist = [classlist] unless classlist.is_a? Array
      classlist << 'baa'
      classlist.uniq!
      doc.div(class: classlist.join(' ')) do
        block&.call
      end
    end


    def step(doc, step_obj, step_classes, box_classes)
      div(doc, step_classes << 'baa-step') do
        div(doc, 'baa-box-process-name') { doc.text step_obj.name }
        box(doc, step_obj, box_classes)
      end
    end

    def file_upload_class(from: nil)
      case from
      when 'mandatory'
        'file-upload-mandatory'
      when 'optional'
        'file-upload-optional'
      else
        'file-upload-not-allowed'
      end
    end

    def box(doc, step, box_classes)
      div(doc, box_classes << 'baa-box') do
        doc.div(class: file_upload_class(from: step.file_upload))
        doc.p { doc.text step.reviewer_count }
      end
    end

    def grid(doc, grid_classes, &block)
      div(doc, grid_classes << 'boxes-and-arrows baa-grid') do
        block.call
      end
    end

    def render
      builder = Nokogiri::XML::Builder.new do |doc|
        grid(doc, @grid_classes) do
          @steps.each_with_index do |step, index|
            step(doc, step, @step_classes, @box_classes)
          end
        end
      end
      builder.doc.to_html(save_with: Nokogiri::XML::Node::SaveOptions::FORMAT |
        Nokogiri::XML::Node::SaveOptions::NO_DECLARATION |
        Nokogiri::XML::Node::SaveOptions::AS_XHTML |
        Nokogiri::XML::Node::SaveOptions::AS_XHTML)
    end
  end
end
