Apartment::Tenant.switch! :intexus

require 'date'


# Fecha inicial: hoy (puedes cambiarla si lo deseas)
start_date = Date.new(2025, 1, 15)
# Fecha final: dos meses adelante (se usa el operador >>)
end_date = start_date >> 3

# Imprimimos el encabezado de la tabla
header = [
  "Fecha",
  "Fecha_termino",
  "360",
  "360_colombia",
  "360_bma",
]
puts header.join(" || ")
puts "-" * 100

# Iteramos sobre cada día entre start_date y end_date
(start_date..end_date).each do |date|
  # Llamadas a los métodos usando la sintaxis tipo date.method(date)
  res1 = start_date.days_360_until(date)
  res2 = start_date.days_360_until_colombia(date)
  res3 = start_date.days_360_until_bma(date)

  # Mostramos la fila de la tabla
  fila = [
    start_date.to_s,
    date.to_s,
    "#{format("%02d", res1)}",
    "#{format("%02d", res2)}",
    "#{format("%02d", res3 + 1)}",
  ]
  puts fila.join(" || ")
end
