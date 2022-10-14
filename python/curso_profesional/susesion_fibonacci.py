from time import sleep


class FiboIter():

    def __init__(self, max_number:int):
        self.max_number = max_number
    
    def __iter__(self):
        self.n1 = 0
        self.n2 = 1
        self.counter = 0
        return self
    
    def __next__(self):

        if self.counter == 0:
            self.counter += 1
            return self.n1
        elif self.counter == 1:
            self.counter += 1
            return self.n2
        else:
            self.aux = self.n1 + self.n2
            
            if self.aux >= self.max_number:
                raise StopIteration
            
            self.n1, self.n2 = self.n2, self.aux
            self.counter += 1
            return self.aux
        

if __name__ == "__main__":
    for element in FiboIter(200):
        print(element)
        sleep(1)


### susesion usando generadores
        
import time

def fibo_gen(limit):
    n1 = 0
    n2 = 1
    counter = 0
    while True:
        if counter == 0:
            counter += 1
            yield n1
        elif counter == 1:
            counter += 1
            yield n2
        else:
            aux = n1 + n2
            n1, n2 = n2, aux
            counter += 1
            yield aux
        if n1+n2 >= limit:
            break

if __name__ == '__main__':
    fibonacci = fibo_gen(30)
    for element in fibonacci:
        print(element)
        time.sleep(1)

