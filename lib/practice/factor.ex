defmodule Practice.Factor do

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def divideUntil(x, v, f) do
    if rem(x, v) == 0 do
      divideUntil(round(x/v), v, f ++ [v])
    else
      [f, x]
    end
  end

  def factorCheck(x, f) do
    if x > 2 do
      f ++ [x]
    else
      f
    end
  end


  def factorAcc(x, f, n, stop) do
    if n >= stop do
      factorCheck(x, f)
    else
      [f, x] = divideUntil(x, n, f)
      if x > 1 do
        factorAcc(x, f, n+2, stop)
      else
        f
      end
    end
  end

  def factor(x) do
    if x == 1 do
      [1]
    else
      IO.puts "X is #{x}"
      [f, x] = divideUntil(x, 2, [])
      IO.puts("F:#{f} X:#{x}")
      factorAcc(x, f, 3, x)
    end
  end
end
