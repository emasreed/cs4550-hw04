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
        case op2 do
          "*" -> 1
          "/" -> 0
          _ -> -1
        end
      else
        if op1 == "+" do
          case op2 do
            "*" -> 1
            "/" -> 1
            "+" -> 0
            _ -> -1
          end
        else
          if op1 == "-" do
            case op2 do
              "-" -> 0
              _ -> 1
            end
          else
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
      if pemdasCompare(value, hd(operator_queue)) < 1 do
        [postfix, [value] ++ operator_queue]
      else
        [greater, lesser] = getAllGreater(hd(operator_queue), operator_queue, [])
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

  def isOperator(val) do
    case val do
      "+" -> true
      "-" -> true
      "/" -> true
      "*" -> true
      _ -> false
    end
  end

  def calculate(op, val1, val2) do
    case op do
      "+" -> Float.to_string(parse_float(val2) + parse_float(val1))
      "-" -> Float.to_string(parse_float(val2) - parse_float(val1))
      "*" -> Float.to_string(parse_float(val2) * parse_float(val1))
      "/" -> Float.to_string(parse_float(val2) / parse_float(val1))
    end
  end

  def calculatePostfix(postfix, num_stack) do
    if postfix == [] do
      hd(num_stack)
    else
      if isOperator(hd(postfix)) do
        calculatePostfix(tl(postfix), [calculate(hd(postfix), hd(num_stack), hd(tl(num_stack)))] ++ tl(tl(num_stack)))
      else
        calculatePostfix(tl(postfix), [hd(postfix)] ++ num_stack)
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
    |> calculatePostfix([])
    |> parse_float

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
