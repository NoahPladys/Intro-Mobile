import { Component, OnInit } from '@angular/core';
import { DataService, Product } from '../services/data.service';

@Component({
  selector: 'app-add-product',
  templateUrl: './add-product.page.html',
  styleUrls: ['./add-product.page.scss'],
})
export class AddProductPage implements OnInit {

  inputName: string = "";
  inputPrice: number | undefined;
  inputBrand: string = "";
  inputDescription: string = "";

  constructor(private data: DataService) { }

  ngOnInit() {
  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }

  addItem() {
    const id = this.getId(this.inputName);
    const newProduct: Product = {
      id: id,
      price: `${this.inputPrice}`,
      name: this.inputName,
      brand: this.inputBrand,
      description: this.inputDescription,
      link: `/products/${id}`
    };
    this.data.addProduct(newProduct).subscribe();
  }

  getId(name: string): string {
    if (name.length >= 3)
      return name.substring(0, 3).toUpperCase();
    else
      return name.toUpperCase()
  }

  inputIsValid(): boolean {
    if (this.inputName && this.inputPrice && this.inputBrand && this.inputDescription)
      return false;
    return true;
  }
}
