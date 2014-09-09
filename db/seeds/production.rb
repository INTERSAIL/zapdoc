root = ZFolder.root
f1 = root.folders.create!(label: 'F1')
f2 = root.folders.create!(label: 'F2')

d11 = f1.documents.create!(label: 'D11', data: 'Hello, I am D11')
d12 = f1.documents.create!(label: 'D12', data: 'Hello, I am D12')
d21 = f1.documents.create!(label: 'D21', data: 'Hello, I am D21')


