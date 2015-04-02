defmodule ESpec.Assertions.Enum.HaveMinBy do

  use ESpec.Assertion

  defp match(enum, [func, val]) do
    result = Enum.min_by(enum, func)
    {result == val, result}
  end

	defp success_message(enum, [func, val], _result, positive) do
    to = if positive, do: "is", else: "is not"
    "The minimum value of `#{inspect enum}` using `#{inspect func}` #{to} `#{val}`."
  end

  defp error_message(enum, [func, val], result, positive) do
    to = if positive, do: "to be", else: "not to be"
    "Expected the minimum value of `#{inspect enum}` using `#{inspect func}` #{to} `#{val}` but the minimum is `#{result}`."
  end

end
