import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';

@Component({
  selector: 'app-modal-confirmar',
  standalone: true,
  imports: [CommonModule, DialogModule, ButtonModule],
  templateUrl: './modal-confirmar.component.html',
  styleUrl: './modal-confirmar.component.css'
})
export class ModalConfirmarComponent {
  @Input() title: string = 'Confirmación';
  @Input() message: string = '¿Está seguro de que desea continuar?';
  @Input() showDialog: boolean = false;
  @Output() showDialogChange = new EventEmitter<boolean>();
  @Output() confirm = new EventEmitter<void>();
  @Output() cancel = new EventEmitter<void>();

  onConfirm() {
    this.confirm.emit();
    this.showDialog = false;
  }

  onCancel() {
    this.cancel.emit();
    this.showDialog = false;
  }
}
