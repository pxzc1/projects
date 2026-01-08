import torch

def verify() -> str:
    print('PyTorch...')
    print(f'Version: {torch.__version__}')
    print(f'CUDA Version: {torch.torch.version.cuda}')
    print(f'CUDA Available: {torch.cuda.is_available()}\n')
