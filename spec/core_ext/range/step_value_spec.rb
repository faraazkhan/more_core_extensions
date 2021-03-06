describe Range do
  STEP_TIME = Time.local('2010', '12', '18', '12', '34', '56', '7890')
  STEP_DAY  = 86_400
  STEP_HOUR = 3_600

  STEP_VALUE_CASES = [
    "Integer Range, inclusive, exact ending", (0..100),  25, [0, 25, 50, 75, 100],
    "Integer Range, exclusive, exact ending", (0...100), 25, [0, 25, 50, 75],

    "Integer Range, inclusive, inexact ending", (0..101),  25, [0, 25, 50, 75, 100, 101],
    "Integer Range, exclusive, inexact ending", (0...101), 25, [0, 25, 50, 75, 100],

    "Time Range (days), inclusive, exact ending", (STEP_TIME - 3 * STEP_DAY)..STEP_TIME,  STEP_DAY, [STEP_TIME - 3 * STEP_DAY, STEP_TIME - 2 * STEP_DAY, STEP_TIME - STEP_DAY, STEP_TIME],
    "Time Range (days), exclusive, exact ending", (STEP_TIME - 3 * STEP_DAY)...STEP_TIME, STEP_DAY, [STEP_TIME - 3 * STEP_DAY, STEP_TIME - 2 * STEP_DAY, STEP_TIME - STEP_DAY],

    "Time Range (hours), inclusive, exact ending", (STEP_TIME - 3 * STEP_HOUR)..STEP_TIME,  STEP_HOUR, [STEP_TIME - 3 * STEP_HOUR, STEP_TIME - 2 * STEP_HOUR, STEP_TIME - STEP_HOUR, STEP_TIME],
    "Time Range (hours), exclusive, exact ending", (STEP_TIME - 3 * STEP_HOUR)...STEP_TIME, STEP_HOUR, [STEP_TIME - 3 * STEP_HOUR, STEP_TIME - 2 * STEP_HOUR, STEP_TIME - STEP_HOUR],

    "Time Range, inclusive, inexact ending", (STEP_TIME - 3 * STEP_DAY)..(STEP_TIME + STEP_HOUR),  STEP_DAY, [STEP_TIME - 3 * STEP_DAY, STEP_TIME - 2 * STEP_DAY, STEP_TIME - STEP_DAY, STEP_TIME, STEP_TIME + STEP_HOUR],
    "Time Range, exclusive, inexact ending", (STEP_TIME - 3 * STEP_DAY)...(STEP_TIME + STEP_HOUR), STEP_DAY, [STEP_TIME - 3 * STEP_DAY, STEP_TIME - 2 * STEP_DAY, STEP_TIME - STEP_DAY, STEP_TIME],

    "Backwards invalid Integer Range, inclusive", (100..0),  25, [],
    "Backwards invalid Integer Range, exclusive", (100...0), 25, [],

    "Backwards invalid Time Range, inclusive", STEP_TIME..(STEP_TIME - 3 * STEP_DAY),  STEP_DAY, [],
    "Backwards invalid Time Range, exclusive", STEP_TIME...(STEP_TIME - 3 * STEP_DAY), STEP_DAY, [],
  ].freeze

  context '#step_value with block' do
    STEP_VALUE_CASES.each_slice(4) do |msg, rng, value, expected|
      it "with #{msg}" do
        ary = []
        rng.step_value(value) { |x| ary << x }
        expect(ary).to eq(expected)
      end
    end
  end

  context '#step_value without block' do
    STEP_VALUE_CASES.each_slice(4) do |msg, rng, value, expected|
      it "with #{msg}" do
        expect(rng.step_value(value)).to eq(expected)
      end
    end
  end
end
