import MapReduce
import sys

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    name = record[0]
    mr.emit_intermediate(name, 1)

def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    mr.emit((key, len(list_of_values)) )

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)