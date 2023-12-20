package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "provinces")
public class Province extends PkEntityBase {

    @Column(name = "province_name", nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "region_fk", referencedColumnName = "id", nullable = false)
    private Region region;

}
