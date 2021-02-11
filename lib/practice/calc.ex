defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def tagOperator(text) do
    case text do
      "+" -> {"op", "+"}
      "-" -> {"op", "-"}
      "/" -> {"op", "/"}
      "*" -> {"op", "*"}
      _ -> {"num", text}
    end
  end

  def pemdasCompare(op1, op2) do
      if op1 == "/" do
        IO.puts "#{op1} IS DIVIDE"
        IO.puts "OP2 IS #{op2}"
        case op2 do
          "*" -> 1
          "/" -> 0
          _ -> -1
        end
      else
        if op1 == "+" do
          IO.puts "#{op1} IS ADD"
          IO.puts "OP2 IS #{op2}"
          case op2 do
            "*" -> 1
            "/" -> 1
            "+" -> 0
            _ -> -1
          end
        else
          if op1 == "-" do
            IO.puts "#{op1} IS SUBTRACT"
            IO.puts "OP2 IS #{op2}"
            case op2 do
              "-" -> 0
              _ -> 1
            end
          else
            IO.puts "#{op1} IS MULTIPLY"
            IO.puts "OP2 IS #{op2}"
            case op2 do
              "*" -> 0
              _ -> -1
            end
          end
        end
      end
  end

  def convertToPostfix(original) do
    convertToPostfixAcc(original, [], [])
  end

  def convertToPostfixAcc(original, postfix, operator_queue) do
    if original == [] do
      IO.puts "OPERATOR QUEUE"
      IO.puts operator_queue
      IO.puts "POSTFIX"
      IO.puts postfix
      postfix ++ operator_queue
    else
      {type, val} = hd(original)
      if type == "op" do
        [postfix, operator_queue]=addToPostfix(val, operator_queue, postfix)
        convertToPostfixAcc(tl(original), postfix, operator_queue)
      else
        convertToPostfixAcc(tl(original), postfix ++ [val], operator_queue)
      end
    end
  end

  def addToPostfix(value, operator_queue, postfix) do
    if operator_queue == [] do
      [postfix, [value]]
    else
      IO.puts value
      IO.puts hd(operator_queue)
      if pemdasCompare(value, hd(operator_queue)) < 1 do
        IO.puts "#{value} less than or equal to #{hd(operator_queue)}"
        [postfix, [value] ++ operator_queue]
      else
        IO.puts "#{value} greater than #{hd(operator_queue)}"
        [greater, lesser] = getAllGreater(hd(operator_queue), operator_queue, [])
        IO.puts "GREATER"
        IO.puts greater
        addToPostfix(value, lesser, postfix ++ greater)
      end
    end
  end

  def getAllGreater(val, lov, acc) do
    if lov == [] do
      [acc, lov]
    else
      if pemdasCompare(val, hd(lov)) < 1 do
        getAllGreater(val, tl(lov), acc ++ [hd(lov)])
      else
        [acc, lov]
      end
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(" ")
    |> Enum.map(&tagOperator/1)
    |> convertToPostfix

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
