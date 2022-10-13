from typing import Tuple, Dict, List

### caso 1
positives: List[int] = [1,2,3,4,5]

users: Dict[str, int] = {
  'argentina': 1,
  'mexico': 34,
  'colombia': 45,
}

countries: List[Dict[str,str]] = [
  {
    'name': 'Argentina',
    'people': '450000', # Cuatrocientos cincuenta mil
  },
  {
    'name': 'México',
    'people': '90000000', # Noventa millones
  },
  {
    'name': 'Colombia',
    'people': '99999999999', #novecientos noventa y nueve mil millones novecientos mil novecientos noventa y nueve
  }
]
print(type(countries))
print(countries)

### caso 2
def suma(a: int, b: int) -> int:
  return a + b

suma = suma('1','2') 
print(type(suma))
print(suma)

### caso 3
CoordinatesType = List[Dict[str, Tuple[int, int]]]

#Una variable que es de tipo CoordinatesType 🤯
coordinates: CoordinatesType = [
  {
    'coord1': (1,2),
    'coord2': (3,5),
  },
  {
    'coord1': (0,1),
    'coord2': (2,5),
  },
]
print(coordinates)
print(type(coordinates))