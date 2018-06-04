# frozen_string_literal: true

require 'securerandom'

# output is limited to 16 chars
# as seen in ``include/linux/sched.h``:
#
# ```c
# /* Task command name length: */
# #define TASK_COMM_LEN 16
# ```
randomizer = lambda do
  ('proc_%<hex>s' % { hex: SecureRandom.hex })[0..14]
end

Sham.config(FactoryStruct, File.basename(__FILE__, '.*').to_sym) do |c|
  c.attributes do
    {
      random: randomizer
    }
  end
end
