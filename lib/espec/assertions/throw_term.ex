defmodule ESpec.Assertions.ThrowTerm do
  
  use ESpec.Assertion

  defp match(subject, []) do
    try do
      subject.()
      {:false, :false}
    catch
      term -> {:true, term}
    end
  end

  defp match(subject, [term]) do
    try do
      subject.()
      {:false, {term, false}}
    catch
      t -> if t == term, do: {true, {t, false}}, else: {:false, {t, :true}}
    end
  end

  defp success_message(subject, [], result, positive) do
    to = if positive, do: "throws", else: "doesn't throw"
    "#{inspect subject} #{to} a term."
  end

  defp success_message(subject, [data], result, positive) do
    to = if positive, do: "throws", else: "doesn't throw"
    "#{inspect subject} #{to} the `#{data}` term."
  end

  defp error_message(subject, [], term, positive) do
    to = if positive, do: "to", else: "to not"
    but = if positive, do: "nothing was thrown", else: "`#{term}` was thrown"
    "Expected `#{inspect subject}` #{to} throw term, but #{but}."
  end

  defp error_message(subject, [data], {term, false}, positive) do
    to = if positive, do: "to", else: "to not"
    but = if positive, do: "nothing was thrown", else: "the `#{term}` was thrown"
    "Expected `#{inspect subject}` #{to} throw #{inspect data}, but #{but}."
  end

  defp error_message(subject, [data], {term, :true}, _positive) do
    "Expected `#{inspect subject}`to throw #{inspect data}, but the `#{term}` was thrown."
  end

end
