import pickle




model = pickle.load(open('C:/Users/Elpatron/Development/projects/healthreminder1/lib/AI/MLforCallories','rb'))

arr = ([[500]])
print(model.predict(arr))