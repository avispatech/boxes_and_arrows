# frozen_string_literal: true

module BoxesAndArrows
  # Renders HTML representing a box and arrow diagram
  class HTMLRenderer
    def initialize(steps: [], box_classes: [], step_classes: [], arrow_classes: [], grid_classes: [])
      @steps = steps
      @box_classes = box_classes
      @step_classes = step_classes
      @arrow_classes = arrow_classes
      @grid_classes = grid_classes
    end

    def div(classlist, &block)
      classlist = [classlist] unless classlist.is_a? Array
      classlist.uniq!
      return "<div class='baa #{classlist.join(" ")}'></div>" if block.nil?

      %(
        <div class='baa #{classlist.join(" ")}'>
          #{block.call}
        </div>
      )
    end

    def arrow(arrow_classes) = div(arrow_classes << 'baa-arrow')

    def step(step_obj, step_classes, box_classes)
      div(step_classes << 'baa-step') do
        %(
          #{div("baa-box-process-name") { step_obj.name }}
          #{box(step_obj, box_classes)}
        )
      end
    end

    def box(step, box_classes)
      div(box_classes << 'baa-box') do
        file_output = case step.file_upload
                      when 'mandatory' then 'mandatory'
                      when 'optional' then 'optional'
                      else 'not-allowed' end

        %(
          div("file-upload-#{file_output}")
          <p>#{step.reviewer_count}</p>
        )
      end
    end

    def grid(grid_classes, &block)
      div(grid_classes << 'boxes-and-arrows baa-grid') do
        block.call
      end
    end

    def render
      grid(@grid_classes) do
        output = ''
        @steps.each_with_index do |step, index|
          output += arrow(@arrow_classes) unless index.zero?
          output += step(step, @step_classes, @box_classes)
        end
        output
      end
    end
  end
end
