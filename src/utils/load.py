import torch
import os

def load_model(model, modelPath: str, optimizer=None) -> str: #optimizer = None is default setting for this func
    checkpoint = torch.load(modelPath)
    
    model.load_state_dict(checkpoint['model_state'])
    
    if optimizer is not None and checkpoint['optimizer_state'] is not None:
        optimizer.load_state_dict(checkpoint['optimizer_state'])
        
    epoch = checkpoint.get('epoch', None)
    return model, optimizer, epoch

    #usage example:
    #model, optimizer, start_epoch = model.load_model(model, 'models/model.pth', optimizer)