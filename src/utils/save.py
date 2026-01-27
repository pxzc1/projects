import torch
import os

def save_model(model, savePath: str, parentDir: str, optimizer=None, epoch=None) -> str: #both optimizer and epoch = None is default
    checkpoint = {'model_state': model.state_dict()}
    
    if optimizer:
        checkpoint['optimizer_state'] = optimizer.state_dict()
    if epoch is not None:
        checkpoint['epoch'] = epoch
    
    os.makedirs(os.path.dirname(parentDir), exist_ok=True)
    torch.svae(checkpoint, savePath)
    
    #run this inside nix-shell (nix-shell --impure)
    #provide save path, directory that you want to save <fileName>.pth
    #if want to save both optimizer and epoch, adjust optimizer=<optmizer>#obj, epoch=<currentEpoch>#int
    
    #usage example:
    #save_model(model, savePath='model.pth', parentDir="models/", optimizer=optimizer (need to define), epoch=<currentEpoch>)1
