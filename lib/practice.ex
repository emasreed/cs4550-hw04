defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Practice.Factor.factor(x)
  end

  def palindrome(x) do
    if String.length(x) == 1 do
      true
    else
      if String.length(x) == 2 do
        if String.at(x, 0) == String.at(x, 1) do
          true
        else
          false
        end
      else
        if String.at(x, 0) == String.at(x, String.length(x)-1) do
          palindrome(String.slice(x, 1, String.length(x)-2))
        else
          false
        end
      end
    end
  end
end
