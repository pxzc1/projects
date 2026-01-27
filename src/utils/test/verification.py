import torch

def verify() -> str:
    
    device = 'cuda' if torch.cuda.is_available() else 'cpu'
    print('')
    print('-'*5 + ' PyTorch Verifications ' + '-'*5)
    print(f'Version: {torch.__version__}')
    print(f'CUDA Version: {torch.torch.version.cuda}')
    print(f'CUDA Available: {torch.cuda.is_available()}')
    print(f'Device: {device.upper()}')
    print(f"GPU: {torch.cuda.get_device_name(0)}\n")

if __name__ == "__main__":
    verify()