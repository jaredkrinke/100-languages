module project_euler_17(
  input clk,
  input reset,
  output reg [3:0] ones_digit,
  output reg [3:0] tens_digit,
  output reg [3:0] hundreds_digit,
  output reg [15:0] letter_count,
  output reg done
);
  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      // Initialization
      ones_digit <= 0;
      tens_digit <= 0;
      hundreds_digit <= 0;
      letter_count <= 0;
      done <= 0;
    end
    else if (!done) begin
      // Calculate next values
      integer next_ones_digit = 0;
      integer next_tens_digit = 0;
      integer next_hundreds_digit = 0;
      integer letters = 0;
      
      // Tens and hundreds digits may not change
      next_tens_digit[3:0] = tens_digit;
      next_hundreds_digit[3:0] = hundreds_digit;
      
      // Increment digit counters, as needed
      if (ones_digit == 9) begin
        next_ones_digit = 0;
        if (tens_digit == 9) begin
          next_tens_digit = 0;
          if (hundreds_digit == 9) begin
            // Add 1,000 (11 letters)
            next_hundreds_digit = 0;
            letters += 11; // one thousand
            done <= 1;
          end
          else
            next_hundreds_digit[3:0] = hundreds_digit + 1;
        end
        else
          next_tens_digit[3:0] = tens_digit + 1;
      end
      else
        next_ones_digit[3:0] = ones_digit + 1;
      
      // Count letters
      if (next_tens_digit != 1) begin
        case (next_ones_digit)
          1: letters += 3; // one
          2: letters += 3; // two
          3: letters += 5; // three
          4: letters += 4; // four
          5: letters += 4; // five
          6: letters += 3; // six
          7: letters += 5; // seven
          8: letters += 5; // eight
          9: letters += 4; // nine
        endcase

        case (next_tens_digit)
          2: letters += 6; // twenty
          3: letters += 6; // thirty
          4: letters += 5; // forty
          5: letters += 5; // fifty
          6: letters += 5; // sixty
          7: letters += 7; // seventy
          8: letters += 6; // eighty
          9: letters += 6; // ninety
        endcase
      end
      else begin
        case (next_ones_digit)
          0: letters += 3; // ten
          1: letters += 6; // eleven
          2: letters += 6; // twelve
          3: letters += 8; // thirteen
          4: letters += 8; // fourteen
          5: letters += 7; // fifteen
          6: letters += 7; // sixteen
          7: letters += 9; // seventeen
          8: letters += 8; // eighteen
          9: letters += 8; // nineteen
        endcase
      end

      case (next_hundreds_digit)
        1: letters += 10; // one hundred
        2: letters += 10; // two hundred
        3: letters += 12; // three hundred
        4: letters += 11; // four hundred
        5: letters += 11; // five hundred
        6: letters += 10; // six hundred
        7: letters += 12; // seven hundred
        8: letters += 12; // eight hundred
        9: letters += 11; // nine hundred
      endcase
      
      // Add "and", if necessary
      if (next_hundreds_digit > 0 && ((next_ones_digit > 0) || (next_tens_digit > 0)))
        letters += 3; // and
      
      // Now that they've been decided, assign next values
      ones_digit <= next_ones_digit[3:0];
      tens_digit <= next_tens_digit[3:0];
      hundreds_digit <= next_hundreds_digit[3:0];
      letter_count <= letter_count + letters[15:0];
    end
  end

endmodule
