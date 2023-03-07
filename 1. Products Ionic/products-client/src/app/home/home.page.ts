import { Component, OnInit } from '@angular/core';
import { RefresherCustomEvent, ViewWillEnter } from '@ionic/angular';

import { DataService, Product } from '../services/data.service';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage implements OnInit, ViewWillEnter {
  constructor(private data: DataService) { this.loadData(); }

  refresh(ev: any) {
    this.loadData();
    (ev as RefresherCustomEvent).detail.complete();
  }

  products!: Product[];

  ngOnInit(): void {
    this.loadData();
  }

  ionViewWillEnter() {
    this.loadData();
  }

  loadData(): void {
    this.data.getProducts().subscribe(data => { this.products = data }, error => { console.log(error) });
  }
}
