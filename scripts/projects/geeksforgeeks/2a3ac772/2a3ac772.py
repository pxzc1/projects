import hashlib

def hashes(file1Path: str, file2Path: str) -> str:
    hash1 = hashlib.sha1()
    hash2 = hashlib.sha1()
    
    try:
        with open(file1Path, 'rb') as file1:
            while chunk := file1.read(1024):
                hash1.update(chunk)
                
        with open(file2Path, 'rb') as file2:
            while chunk := file2.read(1024):
                hash2.update(chunk)
                
        return hash1.hexdigest(), hash2.hexdigest()
    
    except FileNotFoundError as e:
        raise RuntimeError(f'Error: {e}') from e

def check(file1Path: str, file2Path: str) -> str:
    f1, f2 = hashes(file1Path, file2Path)
    
    if (f1 != f2):
        print(f'File {f1!r} and {f2!r} are not identical.')
    else:
        print(f'FIle {f1!r} and {f2!r} are identical.')
        
if __name__ == "__main__":
    check('sample1.pdf', 'sample2.pdf')